{-|
Exercice 1.
1. Définissez, dans un script, une fonction récursive
fusionner  :: [Int] -> [Int] -> [Int]
qui fusionne deux listes triées pour produire une seule liste triée ; par exemple :
> fusionner  [2,5,6] [1,3,4]
[1,2,3,4,5,6]
2. Ajoutez au script la définition d’une fonction récursive
msort :: [Int] -> [Int]
qui implémente le tri par fusion (merge sort en anglais). Cet algorithme de tri peut se spécifier par
les deux règles suivantes :
— les listes de longueur

1
sont déjà triées ;
— on peut trier les autres listes en les découpant en deux morceaux, en triant ces deux morceaux, et
en fusionnant les listes résultantes.
3. Modifiez le script de façon qu’on ait le type
msort :: Ord a => [a] -> [a]
4. Définissez dans le script 5 listes (non triées) de types diffèrents et utilisez ces listes pour tester la
correction de la fonction
msort
.
|-}

{-| 1.1 |-}
fusionner  :: [Int] -> [Int] -> [Int]
fusionner [] xs = xs
fusionner xs [] = xs
fusionner (x:xs) (y:ys)
  | x > y = y : fusionner (x:xs) ys
  | otherwise = x : fusionner xs (y:ys)

{-| 1.2 |-}
msort :: [Int] -> [Int]
msort [] = []
msort (x:[]) = [x]
msort xs =
            fusionner (msort xs1) (msort xs2)
            where
              xs1 = take (((length xs) + 1) `div` 2) xs
              xs2 = drop (((length xs) + 1) `div` 2) xs

{-| 1.3 |-}

fusionner2  :: Ord a => [a] -> [a] -> [a]
fusionner2 [] xs = xs
fusionner2 xs [] = xs
fusionner2 (x:xs) (y:ys)
  | compare x y == GT = y : fusionner2 (x:xs) ys
  | otherwise = x : fusionner2 xs (y:ys)

msort2 :: Ord a => [a] -> [a]
msort2 [] = []
msort2 (x:[]) = [x]
msort2 xs =
            fusionner2 (msort2 xs1) (msort2 xs2)
            where
              xs1 = take (((length xs) + 1) `div` 2) xs
              xs2 = drop (((length xs) + 1) `div` 2) xs

{-|
let list1 = ['a', 'w', 'b', 't']
let list2 = [1,2,3,4,6,9,10]
let list3 = [1.2, 3.0, 2.2, 6.3, 4.5]
let list4 = [(1,3), (4,5), (1,1), (2,3)]
let list5 = [(1,'q'), (4,'a'), (1,'c'), (2,'f')]
|-}

{-|
Exercice 2.
Écrivez la définition d’une fonction
doMenu :: [(String,IO a)] -> IO a
qui prend en para-
mètre une liste de couples
(prompt,action):: (String,IO a)
, affiche à l’écran un menu bien presenté avec
les prompts un par ligne, demande à l’utilisateur de faire un son choix, et ensuite exécute l’action choisie
|-}

doMenu :: [(String,IO a)] -> IO a
