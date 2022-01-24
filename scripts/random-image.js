const fs = require("fs");
const path = require("path");

const FILE_TO_UPDATE = path.resolve(__dirname, "../README.md");
const data = fs
    .readFileSync(FILE_TO_UPDATE, "utf-8")
    .replace(
        /images\/taengoo[0-9]+/,
        `images/taengoo${Math.floor(Math.random() * 5) + 1}`
    )
    .replace(
        /images\/winter[0-9]+/,
        `images/winter${Math.floor(Math.random() * 5) + 1}`
    );

fs.writeFileSync(FILE_TO_UPDATE, data, "utf-8");
