const fs = require("fs");
const path = require("path");

const FILE_TO_UPDATE = path.resolve(__dirname, "../README.md");
const TAENGOO_MAX = 9;
const WINTER_MAX = 9;
const data = fs
    .readFileSync(FILE_TO_UPDATE, "utf-8")
    .replace(
        /images\/taengoo[0-9]+/,
        `images/taengoo${Math.floor(Math.random() * TAENGOO_MAX) + 1}`
    )
    .replace(
        /images\/winter[0-9]+/,
        `images/winter${Math.floor(Math.random() * WINTER_MAX) + 1}`
    );

fs.writeFileSync(FILE_TO_UPDATE, data, "utf-8");
