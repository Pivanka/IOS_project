# IOS Фінальний проект - Finance Tracker
Це програма, в якій ти можеш добавляти свої прибутки і витрати, щоб слідкувати і почати правильно користуватися грошима.

* Маніпуляції над **акаунтами**.
* Маніпуляції над **списком витрат/прибутків**.
* Вибір **категорії** транзакції.
* Перегляд **валют**.


<p align="center">
    <img src="https://i.imgur.com/FWoaZqx.png" height="400px">
</p>

## Хто може користуватися цією програмою

Будь-хто є власником apple продукції. Скоро буде можливість скачувати з AppStore ;)

## Використання

### Список акаунтів

* Тут ти зможеш переглянути всі твої існуючі акаунти(з їхніми рахунками прибутків та витрат)

<details><summary><b>Відкрити фото</b></summary>
    <p align="center">
        <img src="https://i.imgur.com/q9aWvb4.png" height="400px">
    </p>
</details>

* Також ти можеш додавати нові акаунти і редагувати існуючі

<details><summary><b>Відкрити фото</b></summary>
    <p afloat="center">
        <img src="https://i.imgur.com/QaknOe3.png" height="400px">
        <img src="https://i.imgur.com/QdaW0ff.png" height="400px">
    </p>

</details>

### Прибутки/витрати

* Натиснувши на будь-який з акаунтів ти переходиш до View з самими транзакціями 

<details><summary><b>Відкрити фото</b></summary>
    <p align="center">
        <img src="https://i.imgur.com/Wnx8IK3.png" height="400px">
    </p>
</details>

* Їх можна редагувати 
<details><summary><b>Відкрити фото</b></summary>
    <p align="center">
        <img src="https://i.imgur.com/ZEQB2cO.png" height="400px">
    </p>
</details>

* Їх можна додавати (щоб це була витрата з мінусом, прибуток - без) 
<details><summary><b>Відкрити фото</b></summary>
    <p align="center">
        <img src="https://i.imgur.com/XsipiuS.png" height="400px">
    </p>
</details>

* Тут же можна вибрати категорії самої транзакції(так само і вредагуванні її можна змінювати)
<details><summary><b>Відкрити фото</b></summary>
    <p align="center">
        <img src="https://i.imgur.com/F59koFe.png" height="400px">
    </p>
</details>

## Monobank Api

Для того, щоб глянути валюти ми використовували api з monobank

 ```sh
    NetworkManager.fetchCurrencyRates(from: "https://api.monobank.ua/bank/currency") {
            result in DispatchQueue.main.async { [weak self] in
                switch result {
                case let .success(success):
                    guard let self = self
                    else {
                        self?.activityIndicatorView?.stopAnimating()
                        return  }
                    
                    self.currencyRates = Array(success.prefix(3))
                    self.activityIndicatorView?.stopAnimating()
                    self.tableView.reloadData()
                    
                case .failure(_):
                    self?.activityIndicatorView?.stopAnimating()
                    print("Fetching error")
                    
                }
            }
        }
```

<details><summary><b>Відкрити фото</b></summary>
    <p align="center">
        <img src="https://i.imgur.com/2wo459M.png" height="400px">
    </p>
</details>