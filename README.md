# **SampleUnitTest-MATLAB**

## **環境**

+ Windows 10
+ MATLAB R2020b
+ CircleCI

## **フォルダ構成**

+ `src/*.m`: テスト対象のサンプルとして用意したスクリプト。 
+ `test/*.m`: 各種ユニットテストのスクリプト。
+ `setup.m`: パス設定用のスクリプト。
+ `teardown.m`: パス設定の削除用のスクリプト。

## **ユニットテスト作成手順**

### **ユニットテスト用のクラススクリプトの作成**

まず、ユニットテスト用のクラスを作成します。  
テスト対象のスクリプトに対して1つのテストクラスを用意する構成にしています。

```matlab
classdef <ClassName> < matlab.unittest.TestCase
    methods(Test)
        function <FunctionName>(testCase)
            % ユニットテストの内容を記述する
        end

        function <FunctionName>(testCase)
            % ユニットテストの内容を記述する
        end
        ...
```

メンバ関数内では、対象のロジック(関数やクラス)の出力が想定した出力になっているかを検証する処理を実装することになります。  
検証には、[matlab.unittest.qualifications.Verifiable クラス](https://jp.mathworks.com/help/matlab/ref/matlab.unittest.qualifications.verifiable-class.html) を使用することになります。

> 例)  
> 出力の一致確認とかであれば下記のようになります。
> ```matlab
> classdef <ClassName> < matlab.unittest.TestCase
>     methods(Test)
>         function <FunctionName>(testCase)
>             % ロジックの出力を取得
>             excepted = <何かしらの関数とか>
>             % 想定値 (100) との正誤確認
>             testCase.verifyEqual(expected, 100);
>         end
> ```

ユニットテスト用のスクリプトは、メインのロジックと分けておくためにも `test` フォルダを作成して格納しておくのが良いと思います。  
※本リポジトリでは、 `test/unit` フォルダで管理するようにしています。

## **ユニットテストを実行する**

テスト一括実行のAPIとして[runtests](https://jp.mathworks.com/help/matlab/ref/runtests.html)が用意されています。  
テストスクリプト格納フォルダを指定して実行するとができます。  
今回の環境だと下記のコマンドでテストを実行できます。

```matlab
runtests('test')
```

## **ユニットテストの結果を確認する**

runtestsを実行するとコマンドライン上に結果が表示されます。

### **テストが全てパスした場合**

テストを実施すると下記のような結果が表示されます。  
今回用意した `test_saturation.m`には5つのユニットテストがあり、5個すべてのテストがパスしていることが確認できます。

```matlab
test_saturation を実行しています
.....
test_saturation が完了しました
__________


ans = 

  1×5 TestResult 配列のプロパティ:

    Name
    Passed
    Failed
    Incomplete
    Duration
    Details

合計:
   5 Passed, 0 Failed, 0 Incomplete.
   0.065249 秒間のテスト時間。
```

### **テスト内に問題がある場合**

テストを実施すると下記のような結果が表示されます。  
今回用意した `test_saturation.m`には5つのユニットテストがあり、その中の`test_path_through`が失敗していることが確認できます。  
また、失敗テーブルには、どのような値によって失敗しているかを確認することができます。

```matlab
test_saturation を実行しています

================================================================================
test_saturation/test_path_through で検証に失敗しました。
    ----------------
    フレームワーク診断:
    ----------------
    verifyEqual の条件が満たされませんでした。
    --> "isequaln" では数値は等価ではありません。
    --> 失敗テーブル:
            Actual    Expected    Error       RelativeError   
            ______    ________    _____    ___________________

              10         11        -1      -0.0909090909090909

    実際の値:
        10
    必要な値:
        11
    -----------
    スタック情報:
    -----------
    E:\Dropbox\develop\work\repository\github\SampleUnitTest-MATLAB\test\test_saturation.m (test_saturation.test_path_through) (8 行目) 内
================================================================================
.....
test_saturation が完了しました
__________

エラーの概要:

     Name                               Failed  Incomplete  原因
    ===============================================================================
     test_saturation/test_path_through    X                 検証によって失敗しました。

ans = 

  1×5 TestResult 配列のプロパティ:

    Name
    Passed
    Failed
    Incomplete
    Duration
    Details

合計:
   4 Passed, 1 Failed (再実行), 0 Incomplete.
   0.10706 秒間のテスト時間。
```

> [補足]  
> コマンドラインの表示以外にもテスト結果を確認する方法があります。  
> テスト実施時のコマンドを下記のようにすることでテスト結果をワークスペースに保存することができます。
>
> ```matlab
> result = runtests('test')
> ```
>
> result変数をtableに変換すると、どのテストで失敗しているかが一目で確認することができます。
>
> ```matlab
> table(result)
> ```
>
> ※下記、出力結果
>
> ```matlab
> ans =
>
>   5×6 table
>
>                          Name                         Passed    Failed    Incomplete    Duration       Details   
>     ______________________________________________    ______    ______    __________    _________    ____________
>
>     {'test_saturation/test_path_through'         }    false     true        false         0.09328    {1×1 struct}
>     {'test_saturation/test_max_saturation'       }    true      false       false       0.0022358    {1×1 struct}
>     {'test_saturation/test_min_saturation'       }    true      false       false        0.001742    {1×1 struct}
>     {'test_saturation/test_max_datatype_mismatch'}    true      false       false       0.0065018    {1×1 struct}
>     {'test_saturation/test_min_datatype_mismatch'}    true      false       false       0.0035349    {1×1 struct}
> ```
>

## CircleCIを用いたテスト自動化

[MATLAB と Simulink による継続的インテグレーション](https://jp.mathworks.com/solutions/continuous-integration.html) のページによると、MATLABでは CircleCI / GitHub Actions / Azure DevOps / Travis CI などの継続的インテグレーションがサポートされています。
今回は少し使い慣れているCircleCIを使用してテスト自動化の環境を構築してみます。

### **configファイルの作成**

CircleCI Orbsで[matlab](https://circleci.com/developer/orbs/orb/mathworks/matlab#usage-run-tests-with-report)が提供されています。  
それを用いて作成したユニットテストを実施するために`.circleci/config.yml`ファイルを作成します。  
内容は下記の通りとなります。

```yaml
version: 2.1
orbs:
  matlab: mathworks/matlab@0	# matlabのOrbsを指定する
jobs:
  build:
    machine:
      image: 'ubuntu-2204:2022.07.1'
    steps:
      - checkout				# GitHubの資産をチェックアウト
      - matlab/install			# MATLABの環境準備
      - matlab/run-tests:		# runtests('test')が実施される。※以下の行はruntestsの設定
          source-folder: src										# コードが格納されているフォルダを指定
          test-results-junit: test-results/matlab/results.xml		# テストの結果をCircleCIのサイトで確認するための設定
      - store_test_results:
          path: test-results										# テストの結果をCircleCIのサイトで確認するための設定
# ワークフローの設定
# ※GitHubのどのブランチにpushしたとかのイベントをトリガーにするか等の設定が可能
workflows:
  build:
    jobs:
      - build
```

詳細な説明はスキップする（あまり把握できていない、、、）が、CircleCIでGitHubリポジトリとPipelineをつないだ状態で、このconfig.ymlをGitHubにコミットすることで、CircleCI上でテストが実行されるのを確認しました。

## **参考資料**

- [MATLAB でのクラスベースのユニット テストの作成](https://jp.mathworks.com/help/matlab/matlab_prog/author-class-based-unit-tests-in-matlab.html)
- [テスト ケースの結果の解析](https://jp.mathworks.com/help/matlab/matlab_prog/analyze-testsolver-results.html)
- [matlab.unittest.qualifications.Verifiable クラス](https://jp.mathworks.com/help/matlab/ref/matlab.unittest.qualifications.verifiable-class.html)
- [matlab.unittest.TestResult クラス](https://jp.mathworks.com/help/matlab/ref/matlab.unittest.testresult-class.html)
- [MATLAB Actions](https://github.com/matlab-actions)
