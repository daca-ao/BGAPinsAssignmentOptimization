function [ best_Lsum best_Dsum sa_result final_temperature ] = simulatedannealing_swap(inputpins,...  %引脚的初始排列
    numberofpinstoswap,...  %一次迭代之后交换的引脚对数
    rate, m, n, source, ground, threshold)
%    模拟退火算法主体程序

iterations = 0;               %迭代次数初始化
initial_temperature = 10000;  %初始温度
cooling_rate = 0.95;          %降温策略，一个小于1的常数

temperature = initial_temperature;  %先设定初温为当前温度

[ init init_L init_D ] = obj_fun(rate, inputpins, n, source, ground);  %初始解
previous_value = init;
while iterations < threshold
    temp_pins = swappins(inputpins, m, n, numberofpinstoswap);
    [ best L D ] = obj_fun(rate, temp_pins, n, source, ground);
    current_value = best;
    diff = abs(current_value - previous_value);
    if current_value < previous_value  %新解的值比初始解小，取代之。
        inputpins = temp_pins;
        numberofpinstoswap = round(numberofpinstoswap...  %随着温度降低，交换的引脚数目趋于减少，样本趋向稳定
            *exp(-diff/(iterations*temperature)));
        if numberofpinstoswap == 0
            numberofpinstoswap = 1;
        end
        previous_value = current_value;
        init_L = L;
        init_D = D;
        iterations = iterations + 1;
        temperature = cooling_rate*temperature;
    else
        if rand(1) < exp(-diff/(temperature))  %新解的值等于或者大于初始解，按照metropilis准则接受
            inputpins = temp_pins;
            numberofpinstoswap = round(numberofpinstoswap...
                *exp(-diff/(iterations*temperature)));
            if numberofpinstoswap == 0
                numberofpinstoswap = 1;
            end
            previous_value = current_value;
            init_L = L;
            init_D = D;
            iterations = iterations + 1;
        end
    end
end
pinsmatrix = pins(inputpins, m, n, source, ground);
drawpins(pinsmatrix, m, n);

best_Lsum = init_L;
best_Dsum = init_D;
sa_result = previous_value;
final_temperature = temperature;