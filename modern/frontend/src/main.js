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
const resolutionGroup = document.getElementById('resolution-group');
const videoResolutionSelect = document.getElementById('video-resolution');

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

const moonSvg = `<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M21 12.79A9 9 0 1 1 11.21 3 7 7 0 0 0 21 12.79z"></path></svg>`;
const sunSvg = `<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="5"></circle><line x1="12" y1="1" x2="12" y2="3"></line><line x1="12" y1="21" x2="12" y2="23"></line><line x1="4.22" y1="4.22" x2="5.64" y2="5.64"></line><line x1="18.36" y1="18.36" x2="19.78" y2="19.78"></line><line x1="1" y1="12" x2="3" y2="12"></line><line x1="21" y1="12" x2="23" y2="12"></line><line x1="4.22" y1="19.78" x2="5.64" y2="18.36"></line><line x1="18.36" y1="5.64" x2="19.78" y2="4.22"></line></svg>`;

function updateThemeIcon(theme) {
    themeIcon.innerHTML = theme === 'dark' ? moonSvg : sunSvg;
}

// 2. Format Selection Logic (Dynamic Label, Slider Settings & Auto-filtering)
const videoFormats = ['MP4', 'MKV', 'AVI', 'MOV', 'WEBM', 'GIF_VIDEO'];
const audioFormats = ['MP3', 'WAV', 'AAC', 'FLAC', 'OGG', 'M4A'];

const allFormatGroups = {
    images: {
        label: 'Images',
        formats: [
            { value: 'PNG', label: 'PNG' },
            { value: 'JPEG', label: 'JPEG' },
            { value: 'GIF', label: 'GIF (Image)' },
            { value: 'BMP', label: 'BMP' },
            { value: 'TIFF', label: 'TIFF' },
            { value: 'ICO', label: 'ICO' },
        ]
    },
    videos: {
        label: 'Videos',
        formats: [
            { value: 'MP4', label: 'MP4' },
            { value: 'MKV', label: 'MKV' },
            { value: 'AVI', label: 'AVI' },
            { value: 'MOV', label: 'MOV' },
            { value: 'WEBM', label: 'WEBM' },
            { value: 'GIF_VIDEO', label: 'GIF (from Video)' },
        ]
    },
    audios: {
        label: 'Audios',
        formats: [
            { value: 'MP3', label: 'MP3' },
            { value: 'WAV', label: 'WAV' },
            { value: 'AAC', label: 'AAC' },
            { value: 'FLAC', label: 'FLAC' },
            { value: 'OGG', label: 'OGG' },
            { value: 'M4A', label: 'M4A' },
        ]
    }
};

const imageExts = ['PNG', 'JPG', 'JPEG', 'GIF', 'BMP', 'TIFF', 'TIF', 'WEBP', 'ICO'];
const videoExts = ['MP4', 'MKV', 'AVI', 'MOV', 'WEBM', 'FLV', 'WMV', 'M4V', '3GP'];
const audioExts = ['MP3', 'WAV', 'AAC', 'FLAC', 'OGG', 'M4A', 'WMA', 'OPUS'];

function updateAvailableFormats() {
    let hasImage = false;
    let hasVideo = false;
    let hasAudio = false;

    fileList.forEach(f => {
        const fmt = (f.format || '').toUpperCase();
        if (imageExts.includes(fmt)) hasImage = true;
        else if (videoExts.includes(fmt)) hasVideo = true;
        else if (audioExts.includes(fmt)) hasAudio = true;
    });

    let allowedGroups = ['images', 'videos', 'audios'];
    let defaultFormat = 'JPEG';

    if (fileList.length > 0) {
        if (hasImage && !hasVideo && !hasAudio) {
            allowedGroups = ['images'];
            defaultFormat = 'JPEG';
        } else if (hasVideo && !hasImage && !hasAudio) {
            allowedGroups = ['videos', 'audios'];
            defaultFormat = 'MP4';
        } else if (hasAudio && !hasImage && !hasVideo) {
            allowedGroups = ['audios'];
            defaultFormat = 'MP3';
        } else if (hasVideo && hasAudio && !hasImage) {
            allowedGroups = ['audios'];
            defaultFormat = 'MP3';
        }
    }

    const currentVal = targetFormatSelect.value;
    targetFormatSelect.innerHTML = '';

    let isCurrentValAvailable = false;
    allowedGroups.forEach(grpKey => {
        const grp = allFormatGroups[grpKey];
        const optgroup = document.createElement('optgroup');
        optgroup.label = grp.label;
        grp.formats.forEach(f => {
            const opt = document.createElement('option');
            opt.value = f.value;
            opt.innerText = f.label;
            if (f.value === currentVal) {
                isCurrentValAvailable = true;
            }
            optgroup.appendChild(opt);
        });
        targetFormatSelect.appendChild(optgroup);
    });

    if (isCurrentValAvailable) {
        targetFormatSelect.value = currentVal;
    } else {
        targetFormatSelect.value = defaultFormat;
    }

    // Trigger change event to sync resolution and quality sliders
    targetFormatSelect.dispatchEvent(new Event('change'));
}

targetFormatSelect.addEventListener('change', () => {
    const format = targetFormatSelect.value;
    
    // Manage resolution visibility
    if (videoFormats.includes(format)) {
        resolutionGroup.style.display = 'flex';
    } else {
        resolutionGroup.style.display = 'none';
    }

    if (format === 'ICO') {
        qualitySizeLabel.innerText = 'Size (px)';
        qualitySizeInput.min = '16';
        qualitySizeInput.max = '256';
        qualitySizeInput.value = '256';
        qualitySizeValue.innerText = '256';
    } else if (videoFormats.includes(format)) {
        qualitySizeLabel.innerText = 'Video Quality (CRF)';
        qualitySizeInput.min = '1';
        qualitySizeInput.max = '100';
        qualitySizeInput.value = '80';
        qualitySizeValue.innerText = '80';
    } else if (audioFormats.includes(format)) {
        qualitySizeLabel.innerText = 'Audio Quality (Bitrate)';
        qualitySizeInput.min = '1';
        qualitySizeInput.max = '100';
        qualitySizeInput.value = '80';
        qualitySizeValue.innerText = '80';
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

    updateAvailableFormats();

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
        nameTd.className = 'col-name';
        nameTd.innerText = file.name;
        nameTd.title = file.path;
        row.appendChild(nameTd);

        // Size
        const sizeTd = document.createElement('td');
        sizeTd.className = 'col-size';
        sizeTd.innerText = formatBytes(file.size);
        row.appendChild(sizeTd);

        // Original Format
        const formatTd = document.createElement('td');
        formatTd.className = 'col-format';
        formatTd.innerText = file.format;
        row.appendChild(formatTd);

        // Status Badge
        const statusTd = document.createElement('td');
        statusTd.className = 'col-status';
        const badge = document.createElement('span');
        badge.className = `status-badge ${file.status.toLowerCase()}`;
        badge.innerText = file.status;
        statusTd.appendChild(badge);
        row.appendChild(statusTd);

        // Actions
        const actionsTd = document.createElement('td');
        actionsTd.className = 'col-action text-right';
        if (!isConverting) {
            const removeBtn = document.createElement('button');
            removeBtn.className = 'remove-btn';
            removeBtn.title = 'Remove file';
            removeBtn.innerHTML = `
                <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                    <line x1="18" y1="6" x2="6" y2="18"></line>
                    <line x1="6" y1="6" x2="18" y2="18"></line>
                </svg>
                <span>Remove</span>
            `;
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
    const resolution = videoResolutionSelect.value;

    if (!useSource && !destDir) {
        alert('Please select a destination folder.');
        return;
    }

    isConverting = true;
    convertBtn.disabled = true;
    convertBtn.innerHTML = `
        <svg class="spinner-svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round">
            <circle cx="12" cy="12" r="10" stroke-opacity="0.25"></circle>
            <path d="M12 2a10 10 0 0 1 10 10"></path>
        </svg>
        <span>Converting...</span>
    `;
    targetFormatSelect.disabled = true;
    qualitySizeInput.disabled = true;
    sameDirCheckbox.disabled = true;
    browseFolderBtn.disabled = true;
    clearListBtn.disabled = true;
    addMoreBtn.disabled = true;
    videoResolutionSelect.disabled = true;

    renderFileList();
    updateStatus('Conversion started...');

    let successCount = 0;
    let failCount = 0;

    for (let i = 0; i < fileList.length; i++) {
        fileList[i].status = 'Converting';
        renderFileList();

        try {
            await ConvertFile(fileList[i].path, format, qualityOrSize, useSource, destDir, resolution);
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
    convertBtn.innerHTML = `
        <svg class="btn-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
            <polyline points="23 4 23 10 17 10"></polyline>
            <polyline points="1 20 1 14 7 14"></polyline>
            <path d="M3.51 9a9 9 0 0 1 14.85-3.36L23 10M1 14l4.64 4.36A9 9 0 0 0 20.49 15"></path>
        </svg>
        <span>Convert All Files</span>
    `;
    targetFormatSelect.disabled = false;
    qualitySizeInput.disabled = false;
    sameDirCheckbox.disabled = false;
    browseFolderBtn.disabled = false;
    clearListBtn.disabled = false;
    addMoreBtn.disabled = false;
    videoResolutionSelect.disabled = false;

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
