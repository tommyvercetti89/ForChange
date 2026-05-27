import './style.css';
import './app.css';

// Import Go backend methods from Wails bindings
import { SelectFiles, SelectFolder, GetFileInfo, ConvertFile, GetInitialFiles } from '../wailsjs/go/main/App';

// Application State
let fileList = [];
let isConverting = false;

// DOM Elements
const htmlEl = document.documentElement;
const themeToggleBtn = document.getElementById('theme-toggle');
const themeIcon = document.getElementById('theme-icon');
const targetFormatSelect = document.getElementById('target-format');
const qualitySizeLabel = document.getElementById('quality-size-label');
const qualitySizeValue = document.getElementById('quality-size-value');
const qualitySizeInput = document.getElementById('quality-size-input');
const sameDirCheckbox = document.getElementById('same-dir-checkbox');
const folderPickerRow = document.getElementById('folder-picker-row');
const destFolderPathInput = document.getElementById('dest-folder-path');
const browseFolderBtn = document.getElementById('browse-folder-btn');
const convertBtn = document.getElementById('convert-btn');
const dropZone = document.getElementById('drop-zone');
const fileListContainer = document.getElementById('file-list-container');
const fileTableBody = document.getElementById('file-table-body');
const fileCountSpan = document.getElementById('file-count');
const addFilesBtn = document.getElementById('add-files-btn');
const addMoreBtn = document.getElementById('add-more-btn');
const clearListBtn = document.getElementById('clear-list-btn');
const statusBar = document.getElementById('status-bar');

// 1. Theme Management
const savedTheme = localStorage.getItem('theme') || 'dark';
htmlEl.setAttribute('data-theme', savedTheme);
updateThemeIcon(savedTheme);

themeToggleBtn.addEventListener('click', () => {
    const currentTheme = htmlEl.getAttribute('data-theme');
    const newTheme = currentTheme === 'dark' ? 'light' : 'dark';
    htmlEl.setAttribute('data-theme', newTheme);
    localStorage.setItem('theme', newTheme);
    updateThemeIcon(newTheme);
});

function updateThemeIcon(theme) {
    themeIcon.innerText = theme === 'dark' ? '🌙' : '☀️';
}

// 2. Format Selection Logic (Dynamic Label & Slider Settings)
targetFormatSelect.addEventListener('change', () => {
    const format = targetFormatSelect.value;
    if (format === 'ICO') {
        qualitySizeLabel.innerText = 'Size (px)';
        qualitySizeInput.min = '16';
        qualitySizeInput.max = '256';
        qualitySizeInput.value = '256';
        qualitySizeValue.innerText = '256';
    } else {
        qualitySizeLabel.innerText = 'Quality';
        qualitySizeInput.min = '1';
        qualitySizeInput.max = '100';
        qualitySizeInput.value = '80';
        qualitySizeValue.innerText = '80';
    }
});

qualitySizeInput.addEventListener('input', () => {
    qualitySizeValue.innerText = qualitySizeInput.value;
});

// 3. Destination Folder Selector
sameDirCheckbox.addEventListener('change', () => {
    if (sameDirCheckbox.checked) {
        folderPickerRow.style.display = 'none';
        destFolderPathInput.value = '';
    } else {
        folderPickerRow.style.display = 'flex';
    }
});

browseFolderBtn.addEventListener('click', async () => {
    try {
        const folder = await SelectFolder();
        if (folder) {
            destFolderPathInput.value = folder;
            updateStatus(`Destination folder: ${folder}`);
        }
    } catch (err) {
        console.error(err);
        updateStatus('Failed to select destination folder');
    }
});

// 4. File Management (Add, Remove, Clear)
addFilesBtn.addEventListener('click', addFilesHandler);
addMoreBtn.addEventListener('click', addFilesHandler);

async function addFilesHandler() {
    if (isConverting) return;
    try {
        const files = await SelectFiles();
        if (files && files.length > 0) {
            addFilesToList(files);
        }
    } catch (err) {
        console.error(err);
        updateStatus('Failed to select files');
    }
}

function addFilesToList(newFiles) {
    newFiles.forEach(file => {
        // Prevent duplicate paths
        if (!fileList.some(item => item.path === file.path)) {
            fileList.push({
                name: file.name,
                size: file.size,
                format: file.format,
                path: file.path,
                status: 'Pending'
            });
        }
    });
    renderFileList();
    updateStatus(`Added ${newFiles.length} file(s). Total: ${fileList.length}`);
}

clearListBtn.addEventListener('click', () => {
    if (isConverting) return;
    fileList = [];
    renderFileList();
    updateStatus('File list cleared');
});

function formatBytes(bytes) {
    if (bytes === 0) return '0 Bytes';
    const k = 1024;
    const sizes = ['Bytes', 'KB', 'MB', 'GB'];
    const i = Math.floor(Math.log(bytes) / Math.log(k));
    return parseFloat((bytes / Math.pow(k, i)).toFixed(1)) + ' ' + sizes[i];
}

function renderFileList() {
    fileTableBody.innerHTML = '';
    fileCountSpan.innerText = fileList.length;

    if (fileList.length === 0) {
        dropZone.style.display = 'flex';
        fileListContainer.style.display = 'none';
        return;
    }

    dropZone.style.display = 'none';
    fileListContainer.style.display = 'flex';

    fileList.forEach((file, index) => {
        const row = document.createElement('tr');
        
        // Name
        const nameTd = document.createElement('td');
        nameTd.innerText = file.name;
        nameTd.title = file.path;
        row.appendChild(nameTd);

        // Size
        const sizeTd = document.createElement('td');
        sizeTd.innerText = formatBytes(file.size);
        row.appendChild(sizeTd);

        // Original Format
        const formatTd = document.createElement('td');
        formatTd.innerText = file.format;
        row.appendChild(formatTd);

        // Status Badge
        const statusTd = document.createElement('td');
        const badge = document.createElement('span');
        badge.className = `status-badge ${file.status.toLowerCase()}`;
        badge.innerText = file.status;
        statusTd.appendChild(badge);
        row.appendChild(statusTd);

        // Actions
        const actionsTd = document.createElement('td');
        actionsTd.className = 'text-right';
        if (!isConverting) {
            const removeBtn = document.createElement('button');
            removeBtn.className = 'text-btn danger-text';
            removeBtn.innerText = 'Remove';
            removeBtn.addEventListener('click', () => {
                fileList.splice(index, 1);
                renderFileList();
                updateStatus(`Removed file. Total: ${fileList.length}`);
            });
            actionsTd.appendChild(removeBtn);
        } else {
            actionsTd.innerText = '-';
        }
        row.appendChild(actionsTd);

        fileTableBody.appendChild(row);
    });
}

// 5. Drag and Drop Support
window.addEventListener('dragover', (e) => {
    e.preventDefault();
    if (isConverting) return;
    dropZone.classList.add('dragover');
});

window.addEventListener('dragleave', (e) => {
    e.preventDefault();
    dropZone.classList.remove('dragover');
});

window.addEventListener('drop', async (e) => {
    e.preventDefault();
    dropZone.classList.remove('dragover');
    if (isConverting) return;

    const files = e.dataTransfer.files;
    if (!files || files.length === 0) return;

    const newFiles = [];
    for (let i = 0; i < files.length; i++) {
        const file = files[i];
        // WebView2 exposes .path directly for local dropped files
        if (file.path) {
            try {
                const info = await GetFileInfo(file.path);
                if (info) {
                    newFiles.push(info);
                }
            } catch (err) {
                console.error(`Failed to read file info for ${file.path}:`, err);
            }
        }
    }

    if (newFiles.length > 0) {
        addFilesToList(newFiles);
    }
});

// 6. Conversion Trigger
convertBtn.addEventListener('click', async () => {
    if (isConverting || fileList.length === 0) return;

    const format = targetFormatSelect.value;
    const qualityOrSize = parseInt(qualitySizeInput.value);
    const useSource = sameDirCheckbox.checked;
    const destDir = destFolderPathInput.value;

    if (!useSource && !destDir) {
        alert('Please select a destination folder.');
        return;
    }

    isConverting = true;
    convertBtn.disabled = true;
    convertBtn.innerText = '⏳ Converting...';
    targetFormatSelect.disabled = true;
    qualitySizeInput.disabled = true;
    sameDirCheckbox.disabled = true;
    browseFolderBtn.disabled = true;
    clearListBtn.disabled = true;
    addMoreBtn.disabled = true;

    renderFileList();
    updateStatus('Conversion started...');

    let successCount = 0;
    let failCount = 0;

    for (let i = 0; i < fileList.length; i++) {
        fileList[i].status = 'Converting';
        renderFileList();

        try {
            await ConvertFile(fileList[i].path, format, qualityOrSize, useSource, destDir);
            fileList[i].status = 'Success';
            successCount++;
        } catch (err) {
            console.error(`Failed to convert ${fileList[i].path}:`, err);
            fileList[i].status = 'Error';
            failCount++;
        }
        renderFileList();
    }

    isConverting = false;
    convertBtn.disabled = false;
    convertBtn.innerText = '⚡ Convert All Files';
    targetFormatSelect.disabled = false;
    qualitySizeInput.disabled = false;
    sameDirCheckbox.disabled = false;
    browseFolderBtn.disabled = false;
    clearListBtn.disabled = false;
    addMoreBtn.disabled = false;

    renderFileList();
    updateStatus(`Conversion finished. Success: ${successCount}, Failed: ${failCount}`);
    alert(`Conversion completed!\nSuccess: ${successCount}\nFailed: ${failCount}`);
});

function updateStatus(message) {
    statusBar.innerText = message;
}

// Load preloaded files passed through command line
try {
    GetInitialFiles().then(files => {
        if (files && files.length > 0) {
            addFilesToList(files);
        }
    }).catch(err => {
        console.error('Failed to get initial files:', err);
    });
} catch (err) {
    console.error(err);
}
