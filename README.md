# My Windows 11 Setup 💻

When using the Windows 11 USB Installation Media, access CMD by pressing Shift + F10. Then, input the provided commands
![Win11InstallMediaCMD](https://github.com/ZBNZGIT/MyWin11Setup/assets/68793343/91609a8a-0055-472f-bf19-d5af44d294a9)
## Diskpart Commands 💿
MAKE SURE YOU ARE NOT CONNECTED TO THE INTERNET 🌐
```
diskpart
```
```
list disk
```
- Replace X with the disk number that you want to install windows to. Use the command `detail disk` to get drive name
```
sel disk X
```
- Deletes everything off the selected disk
```
clean 
```
- Converts the disk to GPT
```
convert gpt 
```
</br>

## Makes EFI Partition 🖥️ 
```
create partition efi size=100
```
```
format fs=fat32 quick
```
```
assign letter=g:
```
![Win11EFIMade](https://github.com/ZBNZGIT/MyWin11Setup/assets/68793343/d49eca77-cf9a-4edf-b1f7-2280bfde24cc)
</br>

## Makes Primary Partition 📂
```
create partition primary
```
```
format fs=ntfs quick
```
```
assign letter=c:
```
```
exit
```
![Win11PrimaryMade](https://github.com/ZBNZGIT/MyWin11Setup/assets/68793343/cf407bd2-bc17-42b8-823d-56807062a33d)
</br>

## Windows Installation Commands 🚀

```
d:
```
```
cd sources
```
- Find the index number for the version you want to install = #
```
DISM /Get-ImageInfo /imagefile:install.wim
```
```
DISM /apply-image /imagefile:install.wim /index:# /applydir:c:
```

- Create Boot Files And Put In EFI Partition
```
bcdboot c:\Windows /s G: /f UEFI
```
If your system isn't UEFI use one of the following below
- /f BIOS: This is used for BIOS-based systems.
- /f UEFI: This is used for UEFI-based systems.
- /f ALL: This is used to create both BIOS and UEFI bootable partitions.
</br>

## Reboot ♻️
```
wpeutil reboot
```
</br>

## OOBE - Out of Box Experience 🌟
![Win11OOBE](https://github.com/ZBNZGIT/MyWin11Setup/assets/68793343/e51e8449-b4e9-40de-ac37-d18ab1df91c2)
- Once you are in OOBE press Shift + F10 to open CMD And Enter The Following - This will allow you to setup Windows without a Microsoft Account
```
oobe\BypassNRO
```
- System will restart after executing the command. Select Continue with limited Setup and create a local account.
