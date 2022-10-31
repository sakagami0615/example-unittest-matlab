classdef test_sample_function < matlab.unittest.TestCase
    % sample_function のUnitテストクラス

    methods(Test)
        function test_unit_sample_01(testCase)
            % 加算の結果のUnitテスト
            % 加算した出力と一致するかを確認
            expected = sample_function(1, 2);
            testCase.verifyEqual(expected, 3);
        end
        
        function test_unit_sample_02(testCase)
            % 無効な入力(nan)のUnitテスト
            % nanの出力と一致するかを確認
            expected = sample_function(1, nan);
            testCase.verifyEqual(expected, nan);
        end
        
        function test_unit_sample_03(testCase)
            % 無効な入力(Cell)のUnitテスト
            % エラーの出力と一致するかを確認
            testCase.verifyError(@() sample_function(1, {}), 'MATLAB:UndefinedFunction');
        end
    end
end
