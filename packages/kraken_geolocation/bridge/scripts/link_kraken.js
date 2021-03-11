const fs = require('fs');
const path = require('path');
const exec = require('child_process').exec;
const flutterPackageConfig = require('../../.dart_tool/package_config.json');

const kraken = flutterPackageConfig.packages.find(item => item.name === 'kraken');
const rootDir = path.join(__dirname, '..');

if (!kraken) {
    throw new Error('Can not locate kraken package: please run flutter pub get first.');
}

let krakenPath = kraken.rootUri;

if (!path.isAbsolute(krakenPath)) {
    krakenPath = path.join(rootDir, krakenPath);
}

const targetDir = path.join(rootDir, 'kraken');
const targetLibDir = path.join(targetDir, 'lib');
const targetMacOSLibDir = path.join(targetLibDir, 'macos');
const targetIosLibDir = path.join(targetLibDir, 'ios');
const targetAndroidLibDir = path.join(targetLibDir, 'android');

const krakenInclude = path.join(krakenPath, 'include');
const krakenMacOSLib = path.join(krakenPath, 'macos/libkraken_jsc.dylib');
const krakenIosLib = path.join(krakenPath, 'ios/kraken_bridge.framework');
const krakenAndroidLib = path.join(krakenPath, 'android/jniLibs');

fs.mkdirSync(targetDir, {recursive: true});
fs.mkdirSync(targetLibDir, { recursive: true});
fs.mkdirSync(targetMacOSLibDir, { recursive: true});
fs.mkdirSync(targetIosLibDir, { recursive: true});
fs.mkdirSync(targetAndroidLibDir, { recursive: true});

exec(`ln -s ${krakenInclude}`, {
    stdio: 'inherit',
    cwd: targetDir
});
exec(`ln -s ${krakenMacOSLib}`, {cwd: targetMacOSLibDir, stdio: 'inherit'});
exec(`ln -s ${krakenIosLib}`, {cwd: targetIosLibDir, stdio: 'inherit'});
exec(`ln -s ${krakenAndroidLib}`, {cwd: targetAndroidLibDir, stdio: 'inherit'});

