from random import randint
from PyQt5.QtWidgets import *

class CGui:
    def on_btnGen_clicked(self):
        self.strKey = generateOemKey()
        self.labKey.setText("Key: " + self.strKey)

    def on_btnCpy_clicked(self):
        self.app.clipboard().setText(self.strKey)
        QMessageBox.about(self.window, "Success !", "Key copied to the clipboard")

    def __init__(self, parent=None):
        self.app = QApplication([])
        self.window = QWidget()
        self.window.setWindowTitle("PyWin95Keygen")

        self.vbox = QVBoxLayout()
        self.labKey = QLabel("Key: ")
        
        self.hbox = QHBoxLayout()
        self.btnGen = QPushButton("Generate key")
        self.btnCpy = QPushButton("Copy to clipboard")

        self.hbox.addWidget(self.btnGen)
        self.hbox.addWidget(self.btnCpy)

        self.vbox.addWidget(self.labKey)
        self.vbox.addLayout(self.hbox)

        self.window.setLayout(self.vbox)

        self.btnGen.clicked.connect(self.on_btnGen_clicked)
        self.btnCpy.clicked.connect(self.on_btnCpy_clicked)

        self.window.show()
        self.app.exec()

def main():
    gui = CGui()

def generateOemKey() -> str:
    day = randint(0, 366)
    year = randint(95, 102)%100
    unchecked = randint(0, 99999)

    mod7 = list(range(5))

    while True:
        sum = 0
        mod7.clear()
        for i in range(5):
            mod7.append(randint(0, 9))
            sum+=mod7[i]
        if sum%7 == 0:
            break
    
    mod7str = ""
    for i in range(5):
        mod7str += f"{mod7[i]}"

    return f"{day:03}{year:02}-OEM-00{mod7str}-{unchecked:05}"

if __name__ == "__main__":
    main()