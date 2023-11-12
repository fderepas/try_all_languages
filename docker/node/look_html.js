const https = require("https");
const fs = require("fs");
const jsdom = require("jsdom");
const { JSDOM } = jsdom;


const url = "https://pkgs.alpinelinux.org/package/edge/main/x86/nodejs";

https.get(url, (res) => {
    const path = "downloaded.html";
    const writeStream = fs.createWriteStream(path);
    res.pipe(writeStream);
    writeStream.on("finish", () => {
        writeStream.close();
        const content = fs.readFileSync(path).toString();
        const dom = new JSDOM(content);
        const fullVersion =dom.window.document.getElementsByClassName('hint--right')[0].textContent;
        const shortVersion=fullVersion.replace(/-.*/,"");
        console.log(shortVersion)
    });
});
