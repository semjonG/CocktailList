# CocktailList

## Необходимо использовать:

- UIKit Верстка кодом. **SnapKit**
- **Alamofire** (или **Moya**)
- **Codable** для парсинга JSON

## Задание

- Получить данные о коктейлях с публичного API: [`https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=Non_Alcoholic`](https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=Non_Alcoholic)
- Спарcить JSON ответ используя Codable
- Вывести “облако тегов” c названиями полученных коктейлей :
    - выводим их в строку, если новый элемент не умещается, переносим на новую строку. По вертикали и горизонтали расстояние между элементами - 8
    - По клику на тег, он окрашивается в краснофиолетовый градиент

## Выполнено
- MVC
- UIKit
- Alamofire (Decodable, get запрос) 
  
  <img width="256" alt="example" src="https://raw.githubusercontent.com/semjonG/CocktailList/main/screenShot1.png"><br>
