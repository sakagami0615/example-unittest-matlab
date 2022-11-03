classdef test < matlab.unittest.TestCase
    % test のUnitテストクラス
    methods (Static) 
        % テスト開始時に、testフォルダのパスを再登録する
        % (testフォルダ内に配置したmock関数が優先して使用される)
        function setup()
            addpath(genpath('test'));
        end
        
        % テスト終了時時に、sarcフォルダのパスを再登録する
        % (srcフォルダ内に配置した実際の関数が優先して使用される)
        function teardown()
            addpath(genpath('src'));
        end
    end

    methods(Test)
        function test_unit_sample_01(testCase)
            % 加算の結果のUnitテスト
            % 加算した出力と一致するかを確認
            test.setup();
            expected = func(1, 3);
            testCase.verifyEqual(expected, 10003);
            test.teardown();
        end
        
        function test_unit_sample_02(testCase)
            % 加算の結果のUnitテスト
            % 加算した出力と一致するかを確認
            test.setup();
            expected = func(1, -1);
            testCase.verifyEqual(expected, 9999);
            test.teardown();
        end
    end
end
