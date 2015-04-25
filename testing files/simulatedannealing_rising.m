function [ best_Lsum best_Dsum sa_result final_temperature ] = simulatedannealing_rising(inputpins,...  %���ŵĳ�ʼ����
    numberofpinstoswap,...  %һ�ε���֮�󽻻������Ŷ���
    rate, m, n, source, ground)
%    ģ���˻��㷨�������

initial_temperature = 10000;  %��ʼ�¶�
cooling_rate = 0.95;          %���²��ԣ�һ��С��1�ĳ���
rising = 0;

temperature = initial_temperature;  %���趨����Ϊ��ǰ�¶�

[ init init_L init_D ] = obj_fun(rate, inputpins, n, source, ground);  %��ʼ��
previous_value = init;
while temperature > 0.000000001
    temp_pins = swappins(inputpins, m, n, numberofpinstoswap);
    [ best L D ] = obj_fun(rate, temp_pins, n, source, ground);
    current_value = best;
    diff = abs(current_value - previous_value);
    if current_value < previous_value  %�½��ֵ�ȳ�ʼ��С��ȡ��֮��
        inputpins = temp_pins;
        previous_value = current_value;
        init_L = L;
        init_D = D;
        temperature = cooling_rate*temperature;
    else
        if rand(1) < exp(-diff/(temperature))  %�½��ֵ���ڻ��ߴ��ڳ�ʼ�⣬����metropilis׼�����
            inputpins = temp_pins;
            previous_value = current_value;
            init_L = L;
            init_D = D;
        end
    end
    if temperature < 0.2*initial_temperature && rising < 3
        temperature = temperature*2.7;
        rising = rising + 1;
    end
end
pinsmatrix = pins(inputpins, m, n, source, ground);
drawpins(pinsmatrix, m, n);

best_Lsum = init_L;
best_Dsum = init_D;
sa_result = previous_value;
final_temperature = temperature;