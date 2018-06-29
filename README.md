# Cipher
A command line tool for cryptography, written in Haskell.

Compile the program:
```
$ ghc cipher.hs -v0 -no-keep-hi-files -no-keep-o-files
```

Generate a key:
```
$ key=$(openssl rand -base64 6)
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
