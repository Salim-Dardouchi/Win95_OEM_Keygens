document.getElementById("genkey").onclick = function () {
    var key = document.getElementById("key");
    key.innerHTML = generate_win95_key();
};
document.getElementById("copy2clip").onclick = function () {
    var _a;
    var key_text = (_a = document.getElementById("key")) === null || _a === void 0 ? void 0 : _a.innerHTML;
    if (key_text != null) {
        navigator.clipboard.writeText(key_text);
    }
    $("#succtoast").toast('show');
};
function generate_win95_key() {
    /* We have to do all this dumb shit to get strings from the integers we had with padded zeros... */
    var day = Math.floor((Math.random() * 366)).toString().padStart(3, '0');
    var year = Math.floor((95 + Math.random() * 8) % 100).toString().padStart(2, '0');
    var unchk = Math.floor((Math.random() * 99999)).toString().padStart(5, '0');
    var mod7arr = [];
    var sum;
    while (true) {
        sum = 0;
        mod7arr = [];
        for (var i = 0; i < 5; i += 1) {
            mod7arr.push(Math.floor(Math.random() * 9));
            sum += mod7arr[i];
        }
        if (sum % 7 == 0)
            break;
    }
    return "".concat(day).concat(year, "-OEM-00").concat(mod7arr.join(""), "-").concat(unchk);
}
