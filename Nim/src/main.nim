import std/random
import std/strformat
import nigui
import nigui/msgBox

proc GenerateOemKey(): string =

    let
        iDay: int = rand(366)
        iYear: int = (95+rand(7)) mod 100
        iUnchk: int = rand(99999)

    var
        iMod7: int = 0
        arrMod7: array[5, int]
        iCount: int = 0

    while(true):
        iCount = 0

        for i in countup(0,4):
            arrMod7[i] = rand(9)
            iCount += arrMod7[i]

        if(iCount mod 7 == 0):
            break
    
    for i in countup(0, 4):
        iMod7*=10
        iMod7+=arrMod7[i]
    
    return &"{iDay:03}{iYear:02}-OEM-00{iMod7:05}-{iUnchk:05}"

proc main(): void = 
    randomize()
    app.init()
    var window = newWindow("Nim Win95 Keygen")
    window.width = 240.scaleToDpi
    window.height = 64.scaleToDpi

    var strKey = ""

    var vb = newLayoutContainer(Layout_Vertical)
    window.add(vb)

    var labKey = newLabel("Key: ")
    vb.add(labKey)

    var hb = newLayoutContainer(Layout_Horizontal)
    vb.add(hb)

    var btnGen = newButton("Generate Key")
    hb.add(btnGen)

    var btnCpy = newButton("Copy to clipboard")
    hb.add(btnCpy)

    btnGen.onClick = proc(event: ClickEvent) = 
        strKey = GenerateOemKey()
        labKey.text = &"Key: {strKey}"
    
    btnCpy.onClick = proc(event: ClickEvent) = 
        app.clipboardText = strKey
        var mb = msgBox(window, "Key copied to clipboard", "Success !", "Ok")

    window.show()
    app.run()

main()