function [ best_Lsum best_Dsum sa_result final_temperature ] = simulatedannealing(inputpins,...  %引脚的初始排列
    numberofpinstoswap,...  %一次迭代之后交换的引脚对数
    rate, m, n, source, ground, threshold, temperature_iterations)
%    模拟退火算法主体程序

iterations = 0;               %迭代次数初始化
initial_temperature = 10000;  %初始温度
cooling_rate = 0.95;          %降温策略，一个小于1的常数
rising = 0;

temperature = initial_temperature;  %先设定初温为当前温度

% 当前温度状态下若连续10次当前解保持不变，则认为是抽样稳定（内循环稳定）。
% 然后开始降温，进入下一温度状态进行求解。
complete_temperature_iterations = 0;

[ init init_L init_D ] = obj_fun(rate, inputpins, n, source, ground);  %初始解
previous_value = init;
while iterations < threshold
    temp_pins = swappins(inputpins, m, n, numberofpinstoswap);
    [ best L D ] = obj_fun(rate, temp_pins, n, source, ground);
    current_value = best;
    diff = abs(current_value - previous_value);
    if current_value < previous_value  %新解的值比初始解小，取代之。
        inputpins = temp_pins;
        if rem(iterations,100) == 0  %求余数
            pinsmatrix = pins(inputpins, m, n, source, ground);
            drawpins(pinsmatrix, m, n);
        end
        if complete_temperature_iterations >= temperature_iterations  %内循环终止策略（终止次数）
            temperature = cooling_rate*temperature;
            complete_temperature_iterations = 0;
        end
        if m*n > 3000
            numberofpinstoswap = round(numberofpinstoswap...
                *exp(-diff/(iterations*temperature)));
            if numberofpinstoswap == 0
                numberofpinstoswap = 1;
            end
        end
        previous_value = current_value;
        init_L = L;
        init_D = D;
        iterations = iterations + 1;
        complete_temperature_iterations = complete_temperature_iterations + 1;
    else
        if rand(1) < exp(-diff/(temperature))  %新解的值等于或者大于初始解，按照metropilis准则接受
            inputpins = temp_pins;
            if rem(iterations,100) == 0
                pinsmatrix = pins(inputpins, m, n, source, ground);
                drawpins(pinsmatrix, m, n);
            end
            if m*n > 3000
                numberofpinstoswap = round(numberofpinstoswap...
                    *exp(-diff/(iterations*temperature)));
                if numberofpinstoswap == 0
                    numberofpinstoswap = 1;
                end
            end
            previous_value = current_value;
            init_L = L;
            init_D = D;
            iterations = iterations + 1;
            complete_temperature_iterations = complete_temperature_iterations + 1;
        end
    end
    if temperature < 0.2*initial_temperature && rising < 3
        temperature = temperature*2.7;
        iterations = fix(iterations*0.005);
        rising = rising + 1;
    end
end
pinsmatrix = pins(inputpins, m, n, source, ground);
drawpins(pinsmatrix, m, n);

best_Lsum = init_L;
best_Dsum = init_D;
sa_result = previous_value;
final_temperature = temperature;