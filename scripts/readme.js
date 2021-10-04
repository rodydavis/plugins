#!/usr/bin/node

// @ts-check
const fs = require('fs');

const startTag = '<!-- START_PACKAGES -->';
const endTag = '<!-- END_PACKAGES -->';
const subModuleFile = '.gitmodules';
const outputFile = `README.md`;

/**
 * @type {Array<{path?: string, url?: string, name: string}>}
 */
const packages = [];

function parseSubModuleFile(file = subModuleFile) {
    const content = fs.readFileSync(file, 'utf8');
    const lines = content.split('\n');
    for (let i = 0; i < lines.length; i++) {
        // [submodule "packages/fb_auth"]
        // 	path = packages / fb_auth
        // 	url = git@github.com: rodydavis / fb_auth.git
        const line = lines[i];
        if (line.startsWith('[')) {
            const nameStartIdx = line.indexOf('"') + 1;
            const nameEndIdx = line.indexOf('"', nameStartIdx);
            const name = line.substring(nameStartIdx, nameEndIdx);
            packages.push({ name: name.split('/')[1] });
        }
        if (line.trimStart().startsWith('path =')) {
            const pathStartIdx = line.indexOf('=') + 1;
            const pathEndIdx = line.length;
            const path = line.substring(pathStartIdx, pathEndIdx).trim();
            packages[packages.length - 1].path = path;
        }
        if (line.trimStart().startsWith('url =')) {
            const urlStartIdx = line.indexOf('=') + 1;
            const urlEndIdx = line.length;
            let url = line.substring(urlStartIdx, urlEndIdx).trim();
            if (url.endsWith('.git')) {
                url = url.substring(0, url.length - 4);
                url = url.replace('git@github.com:', 'https://github.com/');
            }
            packages[packages.length - 1].url = url;
        }
    }

}

function debugModules() {
    for (const package of packages) {
        console.log('package', package);
    }
}

function updateReadme(file = outputFile) {
    const content = fs.readFileSync(file, 'utf8');
    const lines = content.split('\n');
    const startIdx = lines.findIndex(line => line.trim() === startTag);
    const endIdx = lines.findIndex(line => line.trim() === endTag);
    const newLines = lines.slice(0, startIdx + 1);
    newLines.push(`| Name | Stars | Issues | PRs | Forks |`);
    newLines.push(`| --- | --- | --- |--- |--- |`);
    for (const package of packages) {
        newLines.push(`| [${package.name}](${package.url}) |  ${shield(package.url, 'stars')} | ${shield(package.url, 'issues')} | ${shield(package.url, 'issues-pr')} | ${shield(package.url, 'forks')} |`);
    }
    newLines.push(...lines.slice(endIdx));
    fs.writeFileSync(file, newLines.join('\n'));
}

function shield(url, type) {
    const githubSuffix = url.replace('https://github.com/', '').replace('git@github.com:', '');
    const imageUrl = `![](https://img.shields.io/github/${type}/${githubSuffix})`;
    return imageUrl;
}

parseSubModuleFile();
debugModules();
updateReadme();
