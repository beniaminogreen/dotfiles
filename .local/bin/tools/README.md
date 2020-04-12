# Tools Folder
A git repository of the tools (mostly shell scripts) I use in my workflow

# Scripts
## getbib
getbib is a short shell script that creates BibTex citations from a given DOI using the CrossRef referencing API.
If passed a pdf file, it will extract the text and metadata to find a DOI to use.
### Suggested uses:
```
getbib doi:10.1002/0470841559.ch1 >> $BIB
getbib gelman_reading.pdf nussbaum_reading.pdf >> $BIB
```
## sortbib
sortbib is a sed / awk script that alphabetizes a BibTex bibliography file.
Modifies file in place
### Suggested use:
```
sortbib $BIB
```
### Integrate into your .vimrc with:
```
autocmd BufWritePost *.bib execute "silent !sortbib <amatch>" | edit!
```
## clipqr
clipqr is a shell script that generates a QR code using the contents of the system clipboard and full-screens it.

## arch\_pi
arch\_pi installs a minimal version of Arch Linux for the raspberry pi on an unmounted storage.

### Usage Example:
```
#lsblk
NAME        MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
sdb           8:16   1  14.9G  0 disk
|-sdb1        8:17   1   121M  0 part
`-sdb2        8:18   1  14.7G  0 part
nvme0n1     259:0    0   477G  0 disk
|-nvme0n1p1 259:1    0   200M  0 part /boot
|-nvme0n1p2 259:2    0    12G  0 part [SWAP]
|-nvme0n1p3 259:3    0    30G  0 part /
`-nvme0n1p4 259:4    0 434.8G  0 part /home

#arch_pi /dev/sdb
```
Ideal for quickly sharing links.
