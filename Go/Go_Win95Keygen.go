package main

import (
	"fmt"
	"math/rand"
	"time"

	"github.com/andlabs/ui"
	_ "github.com/andlabs/ui/winmanifest"

	"golang.design/x/clipboard"
)

func main() {
	ui.Main(setupUi)
}

func setupUi() {
	clipboard.Init()

	mainwin := ui.NewWindow("Go W95 Keygen", 250, 72, true)
	mainwin.SetMargined(true)
	mainwin.OnClosing(func(*ui.Window) bool {
		mainwin.Destroy()
		ui.Quit()
		return false
	})
	ui.OnShouldQuit(func() bool {
		mainwin.Destroy()
		return true
	})

	vbox := ui.NewVerticalBox()
	vbox.SetPadded(true)
	mainwin.SetChild(vbox)

	labKey := ui.NewLabel("Key: ")
	vbox.Append(labKey, false)

	hbox := ui.NewHorizontalBox()
	hbox.SetPadded(true)
	vbox.Append(hbox, false)

	strKey := ""

	btn := ui.NewButton("Generate Key")
	btn.OnClicked(func(*ui.Button) {
		strKey = GenerateOemKey()
		labKey.SetText("Key: " + strKey)
	})
	hbox.Append(btn, false)

	btn2 := ui.NewButton("Copy to clipboard")
	btn2.OnClicked(func(*ui.Button) {
		clipboard.Write(clipboard.FmtText, []byte(strKey))
		ui.MsgBox(mainwin, "Success", "Key copied successfully!")
	})
	hbox.Append(btn2, false)

	mainwin.Show()
}

func GenerateOemKey() string {
	rand.Seed(time.Now().UnixMicro())

	var strOemKey string = ""
	var iDay, iYear, iUnchecked int
	iDay = rand.Int() % 367
	iYear = (95 + (rand.Int() % 8)) % 100
	iUnchecked = rand.Int() % 100000

	arrMod7 := [5]int{}
	var iSum int

	for {
		arrMod7 = [5]int{}
		iSum = 0
		for i := 0; i < 5; i++ {
			arrMod7[i] = rand.Int() % 10
			iSum += arrMod7[i]
		}
		if iSum%7 == 0 {
			break
		}
	}

	strArrMod7 := ""

	for i := 0; i < 5; i++ {
		strArrMod7 += fmt.Sprint(arrMod7[i])
	}

	strOemKey = fmt.Sprintf("%.3d%.2d-OEM-00%s-%.5d", iDay, iYear, strArrMod7, iUnchecked)
	return strOemKey
}
