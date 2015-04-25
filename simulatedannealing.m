function [ best_Lsum best_Dsum sa_result final_temperature ] = simulatedannealing(inputpins,...  %���ŵĳ�ʼ����
    numberofpinstoswap,...  %һ�ε���֮�󽻻������Ŷ���
    rate, m, n, source, ground, threshold, temperature_iterations)
%    ģ���˻��㷨�������

iterations = 0;               %����������ʼ��
initial_temperature = 10000;  %��ʼ�¶�
cooling_rate = 0.95;          %���²��ԣ�һ��С��1�ĳ���
rising = 0;

temperature = initial_temperature;  %���趨����Ϊ��ǰ�¶�

% ��ǰ�¶�״̬��������10�ε�ǰ�Ᵽ�ֲ��䣬����Ϊ�ǳ����ȶ�����ѭ���ȶ�����
% Ȼ��ʼ���£�������һ�¶�״̬������⡣
complete_temperature_iterations = 0;

[ init init_L init_D ] = obj_fun(rate, inputpins, n, source, ground);  %��ʼ��
previous_value = init;
while iterations < threshold
    temp_pins = swappins(inputpins, m, n, numberofpinstoswap);
    [ best L D ] = obj_fun(rate, temp_pins, n, source, ground);
    current_value = best;
    diff = abs(current_value - previous_value);
    if current_value < previous_value  %�½��ֵ�ȳ�ʼ��С��ȡ��֮��
        inputpins = temp_pins;
        if rem(iterations,100) == 0  %������
            pinsmatrix = pins(inputpins, m, n, source, ground);
            drawpins(pinsmatrix, m, n);
        end
        if complete_temperature_iterations >= temperature_iterations  %��ѭ����ֹ���ԣ���ֹ������
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
        if rand(1) < exp(-diff/(temperature))  %�½��ֵ���ڻ��ߴ��ڳ�ʼ�⣬����metropilis׼�����
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