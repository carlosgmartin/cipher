# Cipher
A command line tool for cryptography, written in Haskell.

Compile the program:
```
$ ghc cipher.hs -v0 -no-keep-hi-files -no-keep-o-files
```

See usage message:
```
$ ./cipher
usage: cipher {-e | -d} {-v | -a} key
```

Generate a key:
```
$ key=$(openssl rand -base64 6)
$ echo $key
aPFB5ue2
```

Test the [Vigenère cipher](https://en.wikipedia.org/wiki/Vigen%C3%A8re_cipher):
```
$ echo 'Plaintext message.' | ./cipher -e -v $key | ./cipher -d -v $key
Plaintext message.
```

Test the [autokey cipher](https://en.wikipedia.org/wiki/Autokey_cipher)
```
$ echo 'Plaintext message.' | ./cipher -e -a $key | ./cipher -d -a $key
Plaintext message.
```

Encrypt a file:
```
$ cat LICENSE.md | ./cipher -e -a $key > encrypted
$ open encrypted
$ cat encrypted | ./cipher -d -a $key > decrypted
$ diff -s LICENSE.md decrypted
Files LICENSE.md and decrypted are identical
$ rm encrypted decrypted
```
