package gui

import (
	"fmt"
	"os"
	"path/filepath"
	"strings"

	"github.com/lxn/walk"
	. "github.com/lxn/walk/declarative"
	"forchange/converter"
)

// ImageFile represents a single image task in the list
type ImageFile struct {
	Index  int
	Name   string
	Size   int64
	Format string
	Status string
	Path   string
}

// ImageModel binds the list data to the ListView/TableView
type ImageModel struct {
	walk.TableModelBase
	items []*ImageFile
}

func (m *ImageModel) RowCount() int {
	return len(m.items)
}

func (m *ImageModel) Value(row, col int) interface{} {
	item := m.items[row]
	switch col {
	case 0:
		return item.Name
	case 1:
		return fmt.Sprintf("%.1f KB", float64(item.Size)/1024.0)
	case 2:
		return item.Format
	case 3:
		return item.Status
	case 4:
		return item.Path
	}
	return nil
}

// Run starts the 7-Zip styled native Windows GUI
func Run(initialFiles []string) {
	var mainWindow *walk.MainWindow
	var tableView *walk.TableView
	var statusBar *walk.StatusBar
	var statusLabel *walk.StatusBarItem
	var formatComboBox *walk.ComboBox
	var qualityEdit *walk.NumberEdit
	var qualityLabel *walk.Label

	// Destination folder elements
	var useSourceFolderCB *walk.CheckBox
	var destFolderEdit *walk.LineEdit
	var browseDestBtn *walk.PushButton

	model := &ImageModel{items: make([]*ImageFile, 0)}
	formats := []string{
		"PNG", "JPEG", "GIF", "BMP", "TIFF", "ICO",
		"MP4", "MKV", "AVI", "MOV", "WEBM", "GIF (Video)",
		"MP3", "WAV", "AAC", "FLAC", "OGG", "M4A",
	}

	err := MainWindow{
		AssignTo: &mainWindow,
		Title:    "ForChange",
		MinSize:  Size{Width: 580, Height: 480},
		Size:     Size{Width: 580, Height: 480},
		Layout:   VBox{MarginsZero: true, Spacing: 0},
		MenuItems: []MenuItem{
			Menu{
				Text: "&File",
				Items: []MenuItem{
					Action{
						Text:        "&Add Files...",
						OnTriggered: func() { addFiles(mainWindow, model, statusLabel) },
					},
					Separator{},
					Action{
						Text:        "E&xit",
						OnTriggered: func() { mainWindow.Close() },
					},
				},
			},
			Menu{
				Text: "&Help",
				Items: []MenuItem{
					Action{
						Text: "&About ForChange",
						OnTriggered: func() {
							walk.MsgBox(mainWindow, "About ForChange",
								"ForChange Image Converter v1.0\nDeveloped by tommyvercetti89 with the help of Antigravity AI (Google DeepMind).",
								walk.MsgBoxIconInformation)
						},
					},
				},
			},
		},
		Children: []Widget{
			// Top Row: Operations and format selection
			Composite{
				Layout: HBox{Margins: Margins{Left: 5, Top: 5, Right: 5, Bottom: 2}, Spacing: 8},
				Children: []Widget{
					GroupBox{
						Title:  "File Operations",
						Layout: HBox{Margins: Margins{Left: 6, Top: 6, Right: 6, Bottom: 6}, Spacing: 4},
						Children: []Widget{
							PushButton{
								Text: "➕ Add",
								OnClicked: func() {
									addFiles(mainWindow, model, statusLabel)
								},
							},
							PushButton{
								Text: "➖ Remove",
								OnClicked: func() {
									idx := tableView.CurrentIndex()
									if idx >= 0 && idx < len(model.items) {
										model.items = append(model.items[:idx], model.items[idx+1:]...)
										model.PublishRowsReset()
										updateStatus(model, statusLabel)
									}
								},
							},
							PushButton{
								Text: "🗑 Clear",
								OnClicked: func() {
									model.items = nil
									model.PublishRowsReset()
									updateStatus(model, statusLabel)
								},
							},
						},
					},
					GroupBox{
						Title:  "Target Settings",
						Layout: HBox{Margins: Margins{Left: 6, Top: 6, Right: 6, Bottom: 6}, Spacing: 4},
						Children: []Widget{
							Label{Text: "Format:"},
							ComboBox{
								AssignTo:     &formatComboBox,
								Model:        formats,
								CurrentIndex: 1, // Default is JPEG
								OnCurrentIndexChanged: func() {
									if formatComboBox.CurrentIndex() < 0 {
										return
									}
									fmtStr := formats[formatComboBox.CurrentIndex()]
									if fmtStr == "ICO" {
										qualityLabel.SetText("Size (px):")
										qualityEdit.SetRange(16.0, 256.0)
										qualityEdit.SetValue(256.0)
									} else if fmtStr == "MP4" || fmtStr == "MKV" || fmtStr == "AVI" || fmtStr == "MOV" || fmtStr == "WEBM" || fmtStr == "GIF (Video)" {
										qualityLabel.SetText("Quality (CRF):")
										qualityEdit.SetRange(1.0, 100.0)
										qualityEdit.SetValue(80.0)
									} else if fmtStr == "MP3" || fmtStr == "WAV" || fmtStr == "AAC" || fmtStr == "FLAC" || fmtStr == "OGG" || fmtStr == "M4A" {
										qualityLabel.SetText("Quality (Bitrate):")
										qualityEdit.SetRange(1.0, 100.0)
										qualityEdit.SetValue(80.0)
									} else {
										qualityLabel.SetText("Quality:")
										qualityEdit.SetRange(1.0, 100.0)
										qualityEdit.SetValue(80.0)
									}
								},
							},
							Label{
								AssignTo: &qualityLabel,
								Text:     "Quality:",
							},
							NumberEdit{
								AssignTo: &qualityEdit,
								Value:    80.0,
								Decimals: 0,
								MinValue: 1.0,
								MaxValue: 256.0,
							},
						},
					},
					PushButton{
						Text: "⚡ Convert All",
						OnClicked: func() {
							target := formats[formatComboBox.CurrentIndex()]
							quality := int(qualityEdit.Value())
							useSource := useSourceFolderCB.Checked()
							var destDir string
							if !useSource {
								destDir = destFolderEdit.Text()
								if destDir == "" {
									walk.MsgBox(mainWindow, "ForChange", "Please select a destination folder.", walk.MsgBoxIconWarning)
									return
								}
							}
							go convertAll(mainWindow, model, target, quality, useSource, destDir)
						},
					},
				},
			},
			// Second Row: Optional destination folder selection
			GroupBox{
				Title:  "Destination Folder",
				Layout: HBox{Margins: Margins{Left: 8, Top: 4, Right: 8, Bottom: 6}, Spacing: 6},
				Children: []Widget{
					CheckBox{
						AssignTo: &useSourceFolderCB,
						Text:     "Same as source file directory (Default)",
						Checked:  true,
						OnCheckedChanged: func() {
							checked := useSourceFolderCB.Checked()
							destFolderEdit.SetEnabled(!checked)
							browseDestBtn.SetEnabled(!checked)
						},
					},
					LineEdit{
						AssignTo: &destFolderEdit,
						Enabled:  false,
						ReadOnly: true,
					},
					PushButton{
						AssignTo: &browseDestBtn,
						Text:     "...",
						Enabled:  false,
						OnClicked: func() {
							dlg := walk.FileDialog{
								Title: "Select Destination Folder",
							}
							ok, err := dlg.ShowBrowseFolder(mainWindow)
							if err == nil && ok {
								destFolderEdit.SetText(dlg.FilePath)
							}
						},
					},
				},
			},
			// Main ListView (TableView)
			TableView{
				AssignTo:         &tableView,
				AlternatingRowBG: true,
				Columns: []TableViewColumn{
					{Title: "Name", Width: 120},
					{Title: "Size", Width: 80},
					{Title: "Format", Width: 60},
					{Title: "Status", Width: 80},
					{Title: "Path", Width: 220},
				},
				Model: model,
			},
		},
		StatusBarItems: []StatusBarItem{
			{
				AssignTo: &statusLabel,
				Text:     "0 object(s)",
				Width:    200,
			},
		},
	}.Create()

	if err != nil {
		fmt.Fprintf(os.Stderr, "Fatal GUI error: %v\n", err)
		os.Exit(1)
	}

	statusBar = mainWindow.StatusBar()
	_ = statusBar

	// Pre-populate drag-and-drop or context menu file paths
	for _, path := range initialFiles {
		addFileByPath(model, path)
	}
	model.PublishRowsReset()
	updateStatus(model, statusLabel)

	mainWindow.Run()
}

// addFiles shows multiple file picker to select input files
func addFiles(parent *walk.MainWindow, model *ImageModel, statusLabel *walk.StatusBarItem) {
	dlg := walk.FileDialog{
		Title:  "Select Media Files to Convert",
		Filter: "All Supported Media Files (*.png;*.jpg;*.jpeg;*.gif;*.bmp;*.tiff;*.webp;*.ico;*.mp4;*.mkv;*.avi;*.mov;*.webm;*.mp3;*.wav;*.aac;*.flac;*.ogg;*.m4a)|*.png;*.jpg;*.jpeg;*.gif;*.bmp;*.tiff;*.webp;*.ico;*.mp4;*.mkv;*.avi;*.mov;*.webm;*.mp3;*.wav;*.aac;*.flac;*.ogg;*.m4a|Image Files (*.png;*.jpg;*.jpeg;*.gif;*.bmp;*.tiff;*.webp;*.ico)|*.png;*.jpg;*.jpeg;*.gif;*.bmp;*.tiff;*.webp;*.ico|Video Files (*.mp4;*.mkv;*.avi;*.mov;*.webm)|*.mp4;*.mkv;*.avi;*.mov;*.webm|Audio Files (*.mp3;*.wav;*.aac;*.flac;*.ogg;*.m4a)|*.mp3;*.wav;*.aac;*.flac;*.ogg;*.m4a|All Files (*.*)|*.*",
	}

	ok, err := dlg.ShowOpenMultiple(parent)
	if err != nil || !ok {
		return
	}

	for _, path := range dlg.FilePaths {
		addFileByPath(model, path)
	}

	model.PublishRowsReset()
	updateStatus(model, statusLabel)
}

// addFileByPath parses a file path and adds it to the table list
func addFileByPath(model *ImageModel, path string) {
	info, err := os.Stat(path)
	if err != nil {
		return
	}

	ext := strings.ToLower(filepath.Ext(path))
	fmtName := strings.TrimPrefix(ext, ".")
	if fmtName == "" {
		fmtName = "unknown"
	}

	item := &ImageFile{
		Index:  len(model.items),
		Name:   filepath.Base(path),
		Size:   info.Size(),
		Format: strings.ToUpper(fmtName),
		Status: "Pending",
		Path:   path,
	}
	model.items = append(model.items, item)
}

// updateStatus updates the bottom status bar item with the object count
func updateStatus(model *ImageModel, statusLabel *walk.StatusBarItem) {
	if statusLabel != nil {
		statusLabel.SetText(fmt.Sprintf("%d object(s)", len(model.items)))
	}
}

// convertAll runs the background conversion threads for all files
func convertAll(parent *walk.MainWindow, model *ImageModel, targetFormat string, quality int, useSource bool, destDir string) {
	var successCount, failCount int

	for i, item := range model.items {
		// Update status to Converting... safely on the GUI thread
		parent.Synchronize(func() {
			item.Status = "Converting..."
			model.PublishRowChanged(i)
		})

		var outPath string
		if !useSource {
			ext := "." + strings.ToLower(targetFormat)
			if strings.ToLower(targetFormat) == "jpeg" {
				ext = ".jpg"
			}
			base := filepath.Base(item.Path)
			name := strings.TrimSuffix(base, filepath.Ext(base))
			outPath = filepath.Join(destDir, name+ext)
		}

		err := converter.Convert(item.Path, outPath, targetFormat, quality, "")

		// Update final conversion status on the GUI thread
		parent.Synchronize(func() {
			if err != nil {
				item.Status = "Error"
				failCount++
			} else {
				item.Status = "Success"
				successCount++
			}
			model.PublishRowChanged(i)
		})
	}

	parent.Synchronize(func() {
		walk.MsgBox(parent, "ForChange",
			fmt.Sprintf("Conversion finished!\nSuccess: %d\nFailed: %d", successCount, failCount),
			walk.MsgBoxIconInformation)
	})
}
