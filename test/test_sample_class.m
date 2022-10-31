classdef test_sample_class < matlab.unittest.TestCase
    % sample_class のUnitテストクラス
    
    methods(Test)
        function test_unit_sample_01(testCase)
            % 加算の結果のUnitテスト
            % 加算した出力と一致するかを確認
            obj = sample_class(1, 1);
            expected = obj.method1(2);
            testCase.verifyEqual(expected, 4);
        end
        
        function test_unit_sample_02(testCase)
            % 無効な入力(nan)のUnitテスト
            % nanの出力と一致するかを確認
            obj = sample_class(1, nan);
            expected = obj.method1(2);
            testCase.verifyEqual(expected, nan);
        end
        
        function test_unit_sample_03(testCase)
            % 無効な入力(Cell)のUnitテスト
            % エラーの出力と一致するかを確認
            testCase.verifyError(@() sample_class(1, {}), 'MATLAB:UndefinedFunction');
        end
    end
end
