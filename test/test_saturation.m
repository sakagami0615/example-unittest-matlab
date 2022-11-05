%% test_saturation のUnitテストクラス
classdef test_saturation < matlab.unittest.TestCase
    methods(Test)
        
        % saturation無しの動作確認
        function test_path_through(testCase)
            expected = saturation(10, 11, 9);
            testCase.verifyEqual(expected, 10);
        end
        
        % 最大値saturationの動作確認
        function test_max_saturation(testCase)
            expected = saturation(11, 10, 5);
            testCase.verifyEqual(expected, 10);
        end
        
        % 最小値saturationの動作確認
        function test_min_saturation(testCase)
            expected = saturation(9, 15, 10);
            testCase.verifyEqual(expected, 10);
        end
        
        % 最大値データ型の不一致時の動作確認
        function test_max_datatype_mismatch(testCase)
            testCase.verifyError(@()saturation(11, '10', 5), 'saturation:variableDataTypeMismatch');
        end
        
        % 最小値データ型の不一致時の動作確認
        function test_min_datatype_mismatch(testCase)
            testCase.verifyError(@()saturation(9, 15, '10'), 'saturation:variableDataTypeMismatch');
        end
        
    end
end
