# iOS-Utils
Репозиторий MAD, включающий коллекцию утилит для работы с iOS приложениями

## Как установить

Для установки необходимо добавить следующий код в ваш `Podfile`

```Ruby
pod 'MadUtils'
```

## Зависимости
- [Alamofire 5.0.0](https://github.com/Alamofire/Alamofire)
- [Nuke](https://github.com/kean/Nuke)

## Список файлов

- Bundle+Extensions - расширение Bundle для возможности run-time изменения локализации приложения
- EZYGradientView - подкласс UIView, реализующий работу с градиентом
- GradientButton - подкласс UIButton, добавляющий градиент
- GradinetView - список классов для работы с градиентом
- GrowingTextView - подкласс UITextView, реализующий возможность автоматической смены размеров UITextView (см. набор текста в мессенджерах для отправки сообщения)
- ImageScrollView - подкласс UIScrollView для работы с коллекцией UIImageView
- MulticastDelegate - что-то очень полезное :) На самом деле это класс, управляющий коллекцией Delegate для синхронного вызова методов
- RequestProtocol - протокол для классов, работающий с Alamofire
- SearchWithIconClearButtonTextField - UITextField с возможностью добавления searchIcon в левую часть и кастомной clearButton
- StoreReviewHelper - rate App функционал
- String+Extensions
- UIAlertController+Extensions
- UIColor+Extensions
- UIDevice+Extensions
- UIImage+Extensions
- UIImageView+Extensions
- UILabel+Extensions
- UITextField+Extensions
- UITextView+Extensions
- UIView+Extensions
- UIViewController+Extensions
- UserDefaults+Extensions
