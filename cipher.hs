import qualified Data.Map
import qualified Data.Char
import qualified System.Environment

alphabet = '\n' : filter Data.Char.isPrint ['\0'..'\128']

encode = (Data.Map.!) (Data.Map.fromList (zip alphabet [0..]))
decode = (Data.Map.!) (Data.Map.fromList (zip [0..] alphabet))

add a b = decode (mod (encode b + encode a) (length alphabet))
sub a b = decode (mod (encode b - encode a) (length alphabet))

encrypt_vigenere = zipWith add . cycle
decrypt_vigenere = zipWith sub . cycle

encrypt_autokey key plaintext = zipWith add plaintext (key ++ plaintext)
decrypt_autokey key [] = []
decrypt_autokey (k:ks) (c:cs) = 
    let char = sub k c in 
        char : decrypt_autokey (ks ++ [char]) cs

main = do
    args <- System.Environment.getArgs
    contents <- getContents
    putStr $ if length args == 3 && 
        elem (init args) (sequence [["-e", "-d"], ["-v", "-a"]])
        then if null (last args)
            then "key cannot be empty\n"
            else (case init args of
                ["-e", "-v"] -> encrypt_vigenere
                ["-d", "-v"] -> decrypt_vigenere
                ["-e", "-a"] -> encrypt_autokey
                ["-d", "-a"] -> decrypt_autokey
            ) (last args) contents
        else "usage: cipher {-e | -d} {-v | -a} key\n"
