function main() {
    let key = document.getElementById("key");
    key.innerHTML = generate_win95_key();
}

function to_clipboard() {
    let key_text: string = document.getElementById("key")?.innerHTML;
    if (key_text != null) {
        navigator.clipboard.writeText(key_text);
    }
}

function generate_win95_key(): string {
    /* We have to do all this dumb shit to get strings from the integers we had with padded zeros... */
    let day:   string   = Math.floor((Math.random() * 366)).toString().padStart(3, '0');
    let year:  string   = Math.floor((95 + Math.random() * 8) % 100).toString().padStart(2, '0');
    let unchk: string   = Math.floor((Math.random() * 99999)).toString().padStart(5, '0');

    let mod7arr: Array<number> = [];
    let sum: number;

    while (true) {
        sum = 0;
        mod7arr = [];
        for (let i = 0; i < 5; i += 1) {
            mod7arr.push(Math.floor(Math.random() * 9));
            sum += mod7arr[i];
        }

        if (sum % 7 == 0) break;
    }


    return `${day}${year}-OEM-00${mod7arr.join("")}-${unchk}`;
}
