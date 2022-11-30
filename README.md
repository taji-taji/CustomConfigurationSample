# CustomConfigurationSample

Custom Build Configuration を利用しているプロジェクトを debug と production だけで動くようにするためのサンプル。

## 背景

- SwiftPM でのマルチモジュール構成にした場合、ほとんどのコードをローカルパッケージにすることでプロジェクトファイルが管理するものが最小限になる
- これによって、従来の Custom Build Configuration でやっていたことは「プロジェクトファイルを分ける」という方法で実現可能である
- ただし、ほとんどのコードをローカルパッケージに移行できた場合に有効な手段であり、歴史が長く一定の負債もあるプロジェクトで一気にローカルパッケージに移行できないものもある
- その場合、部分的にマルチモジュール化を進める戦略となるが、その場合に従来の Custom Build Configuration でやっていたことを代替するための前述とは別の方法が必要となる
- このサンプルは、「プロジェクトファイルを分ける」方法以外で従来の Custom Build Configuration 相当のことを実現するためのものである

## 方針

### ローカルパッケージの設定について

#### マクロの定義

- package manifest にて各ターゲットに `SwiftSetting.define(_:_:)` を用いることでマクロの定義ができる
- Package.swift 内で Custom Build Configuraion に相当する環境変数を読み取り、その値によってターゲットに定義する `SwiftSetting.define(_:_:)` の値を変える

### Xcode プロジェクトの Build Settings について

- 従来 Custom Build Configuration によって値を変えていた Build Settings については全て、それぞれの Configuration 用の xcconfig ファイルに移行する
- xcodebuild のオプションに任意の xcconfig ファイルを指定することで、 debug と release 以外の Build Settings を上書きするようにする

```sh
BUILD_CONFIGURATION=AD_HOC \ # ← Package.swift で読み込ませるために必要
  xcrun xcodebuild \
  -configuration Release \
  -xcconfig CustomConfigurationSample/Configurations/AdHoc.xcconfig \ # ← Xcode プロジェクトの　Build Settings を上書きするために任意の xcconfig を指定
  -project CustomConfigurationSample.xcodeproj \
  -scheme CustomConfigurationSample \
  -destination 'platform=iOS Simulator,name=iPhone 14,OS=16.1'
```

## 懸念点

- Xcode アプリで Package.swift の環境変数を読み込ませるのが面倒
    - 一度 Xcode アプリを閉じた上で次のようにして開く必要がある
    ```sh
    BUILD_CONFIGURATION=AD_HOC open CustomConfigurationSample.xcodeproj
    ```
    - Xcode アプリでは基本的に Debug しか使わず、 Custom Build Configuration 相当は CI 環境でしか使わないという運用であればここは許容できるかも
