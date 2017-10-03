import Data.Char ( isAlpha, digitToInt )

{-|
Exercice 1 : Informations sur types et classes dans ghci. Considérez l’algorithme qsort présenté en premier cours :
  qsort [] = []
  qsort ( x : xs ) =
    qsort smaller ++ [ x ] ++ qsort larger
    where
      smaller = [ a | a <- xs , a < x ]
      larger = [ b | b <- xs , x < b ]
  1. Copiez cet algorithme dans un script, qui sera chargé avec ghci.
  2. Tapez :type qsort dans ghci et expliquez la réponse donnée.
  3. Tapez :info Ord dans ghci et decodez la réponse donnée.
-}
qsort [] = []
qsort ( x : xs ) =
  qsort smaller ++ [ x ] ++ qsort larger
  where
    smaller = [ a | a <- xs , a < x ]
    larger = [ b | b <- xs , x < b ]

{- |
Exercice 2. Considérez la fonction safetail qui se comporte exactement comme tail, sauf qu’elle envoie la liste
vide vers elle même (rappel : tail [] produit un erreur).
Définissez, dans un script, trois versions de la fonction safetail en utilisant :
  (a) une expression conditionnelle ;
  (b) des équations avec conditions de garde ;
  (c) le filtrage par motifs.
  (c) le filtrage par motifs en utilisant les expressions case .. of
-}
-- a safetail par une expression conditionelle
safetailA:: [a] -> [a]
safetailA xs = if null xs
  then
    xs
  else
    tail xs

-- b safetail par des équations avec conditions de garde
safetailB:: [a] -> [a]
safetailB xs
  | null xs = []
  | otherwise = tail xs

-- (c) le filtrage par motifs.
safetailC:: [a] -> [a]
safetailC [] = []
safetailC (x:xs) = xs

-- (d) le filtrage par motifs en utilisant les expressions case .. of.
safetailD:: [a] -> [a]
safetailD xs = case xs of [] -> []
                          (_:ys) -> ys


{- |
Exercice 3. Dans le script suivant on définit une fonction qui calcule la longueur du plus grand préfixe d’une chaîne
de caractères composé par des lettres seulement :
import Data . Char ( isAlpha )
lengthPrefixAlpha :: String -> Int
lengthPrefixAlpha xs = if xs == [] then 0 else
if isAlpha ( head xs ) then
1 + lengthPrefixAlpha ( tail xs )
else 0
Copiez ce script, et ajoutez trois définitions alternatives de la même fonction
1. en utilisant les conditions de garde,
2. en utilisant le filtrage par motifs,
3. en utilisant le filtrage par motifs par des expressions case .. of,
4. en utilisant les fonctions takeWhile et length.
-}

lengthPrefixAlpha :: String -> Int
lengthPrefixAlpha xs =
  if xs == []
  then
    0
  else
    if isAlpha ( head xs )
    then
      1 + lengthPrefixAlpha ( tail xs )
    else
      0

-- 1 en utilisant les conditions de garde,
lengthPrefixAlpha1 :: String -> Int
lengthPrefixAlpha1 xs
  | null xs = 0
  | isAlpha (head xs) = 1 + lengthPrefixAlpha1 (tail xs)
  | otherwise = 0

-- 2 en utilisant le filtrage par motifs,
lengthPrefixAlpha2 :: String -> Int
lengthPrefixAlpha2 [] = 0
lengthPrefixAlpha2 (x:xs) =
  if isAlpha x
  then
    1 + lengthPrefixAlpha2 xs
  else
    0

-- 3. en utilisant le filtrage par motifs par des expressions case .. of,
lengthPrefixAlpha3 :: String -> Int
lengthPrefixAlpha3 xs =
  case xs of [] -> 0
             (x:xs) -> if isAlpha x then 1 + lengthPrefixAlpha3 xs else 0

-- 4. en utilisant les fonctions takeWhile et length.
lengthPrefixAlpha4 :: String -> Int
lengthPrefixAlpha4 xs = length (takeWhile isAlpha xs)


{-|
Expressions lambda
Exercice 4 : Se familiariser avec les expressions lambda. Considérez le script suivant :
carre x = x ^2
moyenne ns = sum ns / fromIntegral ( length ns )
norme ns = sqrt ( moyenne ( map carre ns ))
main = print ( norme [1..5])
1. Ajoutez, dans le script, la déclaration du type avant chaque fonction définie.
2. En utilisant la notation lambda, éliminez du script toute définition intermédiaire (carre, moyenne, norme) en
définissant ainsi le main dans une seule expression.
-}
moyenFloat xs = (sum xs) / fromIntegral (length xs)
square x = x*x

calSuite x y = sqrt (square (x-y))

ecartMoyen xs = moyenFloat (map (`calSuite` m) xs)
  where
    m = moyenFloat xs

-- 1
carre :: Num a => a -> a
carre x = x ^2

--moyenne:: Num a => [a] -> a
moyenne :: (Fractional a, Foldable t) => t a -> a
moyenne ns = sum ns / fromIntegral ( length ns )

norme :: Floating a => [a] -> a
norme ns = sqrt ( moyenne ( map carre ns ))
norme' ns = sqrt ( (\xs -> sum xs / fromIntegral (length xs)) (map (\x->x^2) ns))


main:: IO ()
main = print ( (\ns -> sqrt ( (\xs -> sum xs / fromIntegral (length xs)) (map (\x->x^2) ns) ) ) [1..5])


{-|
Exercice 5. Considérez les définitions des fonctions power et distMoy suivantes :
power 0 = \ _ -> \ x -> x
power n = \ f -> \ x -> f ( power (n -1) f x )
distMoy = \ xs ys -> (\ zs - > sum zs / fromIntegral ( length zs ))
( map (\( x , y ) -> abs ( x - y )) ( zip xs ys ))
En utilisant ghci
1. donnez un type à ces fonctions, et à toute expression lambda intermédiaire ;
2. testez ces deux fonctions, et donnez une description ce ce qu’ils font en général ;
3. réécrivez ces deux définitions en utilisant une notation qui vous est (peut être) plus habituelle ; par exemple :
— déplacez, dans la définition d’une fonction, les paramètres formels de droite à gauche du l’égalité ;
— introduisez des définitions (et des noms) intermédiaires pour les fonctions anonymes.
-}
power :: (Eq t1, Num t1) => t1 -> (t -> t) -> t -> t
power 0 = \ _ -> \ x -> x
power n = \ f -> \ x -> f ( power (n -1) f x )

distMoy :: [Double] -> [Double] -> Double
distMoy = \ xs ys -> (\ zs -> sum zs / fromIntegral ( length zs ))
                      ( map (\( x , y ) -> abs ( x - y )) ( zip xs ys ))
abs' (x, y) = abs ( x - y )
distMoy1 xs ys = moyenne (map abs' (zip xs ys))
distMoy2 xs ys = moyenne2 (map abs2 (zip xs ys))
  where
    moyenne2 ns = sum ns / fromIntegral ( length ns )
    abs2 (x, y) = abs ( x - y )
{-|
Exercice 6.
Le produit scalaire de deux listes d’entiers xs et ys de longueur n
-}
produitScalaire:: [Int] -> [Int] -> Int
produitScalaire xs ys
  |length xs == length ys = sum([x*y | (x, y) <- (zip xs ys)])
  |otherwise = error "Two lists must have the same length"

produitScalaire2 xs ys = sum (map (\ (x,y) -> x*y) (zip xs ys))


{-|
Exercice 7.
Un nombre positif est
parfait
s’il est la somme de tous ses facteurs, sauf lui même. En utilisant la
compréhension, définissez une fonction
perfects  :: Int  -> [Int]
qui retourne la liste de tous les nombres parfaits, jusqu’à la limite passée en paramètre. (Utilisez la fonction
factors
vue en cours)
-}

--digits :: Integer -> [Int]
--digits = map (read . (:[])) . show
--digist = map (read )

{-|
toDigits :: Integer -> [Integer] -- 12 -> [1,2], 0 -> [0], 10 -> [1,0]
toDigits x
    | x < 10 = [x]
    | otherwise = toDigits (div x 10) ++ [mod x 10]
-}
factors :: Int -> [Int]
factors n = [x | x <- [1..n], (n `mod` x) == 0, x /= n]

perfects :: Int -> [Int]
perfects x = [y | y <- [1.. x], sum(factors y) == y]


{-|
Ex 8
pyths :: Int -> [(Int ,Int ,Int)]
|-}
pyths :: Int -> [(Int ,Int ,Int)]
pyths n = [ (x, y, z) | x <- [1..n], y <- [1..n], z <- [1..n], x^2 + y^2 == z^2]

pyths1 :: Int -> [(Int ,Int ,Int)]
pyths1 n = [ (x, y, z) | x <- [1..n], y <- [1..n], z <- [1..n], x < z, y < z, x^2 + y^2 == z^2]

pyths2 :: Int -> [(Int ,Int ,Int)]
pyths2 n = [ (x, y, z) | x <- [1..n], y <- [1..n], z <- [1..n], x < z, y < z, x^2 + y^2 == z^2]
