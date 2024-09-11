# Filesystem Partitioning & Encryption
An encrypted file system is almost as good as a destroyed drive. Data will not be recovered without the decryption key.

## Linux Unified Key Setup
When a partition is encrypted with LUKS the disk layout looks like:

| Layout | Description |
| ------ | ----------- |
| LUKS phdr | information about the UUID, cipher, cipher mode, key length and checksum of master key |
| KM1 | Key material (KM1 - KM8) |
| ... | Contains a copy of the master key encrypted with a user password. |
| KM8 | Will contain a key foreach user |
| Bulk Data | Encrypted data |

## Encryption Example
LUKS reuses block encryption implementations(pseudo code):
```sh
enc_data = encrypt(cipher_name, cipher_mode, key, original, original_length)
```

The user supplied password is used for the encryption key; the key is derived PBKDF2.
```sh
key = PBKDF2(password,salt,interation_count, derived_key_length)
```

## Decryption Example
```sh
original = decrypt(cipher_name, cipher_mode, key, enc_data, original_length)
```

## Opening Encrypted drives
```sh
sudo cryptsetup open --type luks secretvault.img <name> && sudo mount /dev/mapper/<name> <mount name>
```

### Setup Steps
Take the following steps to implement LUKS

1. Install tool using any of:
```sh
yum install cryptsetup-luks
apt install cryptsetup
dnf install cryptsetup-luks
```

2. Get partition name 
```sh
fdisk -l
lsblk
blkid

# or create a new one
fdisk
```

3. Setup parition 
```sh
cryptsetup -y -v luksFormat /dev/sdb1
```

4. Create mapping:
```sh
cryptsetup luksOpen /dev/sdb1 EDCdrive
```

5. Confirm mapping details:
```sh
ls -l /dev/mapper/EDCdrive
cryptsetup -v status EDCdrive
```

6. Overwrite existing data:
```sh
dd if=/dev/zero of=/dev/mapper/EDCdrive
```

7. Format 
```sh
mkfs.ext4 /dev/mapper/EDCdrive -L "Strategos USB"
```

8. Mount and start 
```sh
mount /dev/mapper/EDCdrive /media/secure-USB`
```
9. Confirm the installation
```sh
cryptsetup luksDump /dev/sdb1
```

