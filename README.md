# Cipher
A command line tool for cryptography, written in Haskell.

Compile the program:
```
$ ghc cipher.hs -v0 -no-keep-hi-files -no-keep-o-files
```

See usage message:
```
$ ./cipher
usage: {vige | auto} {enc | dec} key
```

Generate a key:
```
$ key=$(openssl rand -base64 6)
$ echo $key
aPFB5ue2
```

Test the [Vigenère cipher](https://en.wikipedia.org/wiki/Vigen%C3%A8re_cipher):
```
$ echo 'Plaintext message.' | ./cipher enc vige $key | ./cipher dec vige $key
Plaintext message.
```

Test the [autokey cipher](https://en.wikipedia.org/wiki/Autokey_cipher)
```
$ echo 'Plaintext message.' | ./cipher enc auto $key | ./cipher dec auto $key
Plaintext message.
```

Encrypt a file:
```
$ cat LICENSE.md | ./cipher enc auto $key > encrypted
$ open encrypted
$ cat encrypted | ./cipher dec auto $key > decrypted
$ diff -s LICENSE.md decrypted
Files LICENSE.md and decrypted are identical
$ rm encrypted decrypted
```
