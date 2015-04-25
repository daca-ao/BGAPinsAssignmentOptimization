%  ģ���˻��㷨���Գ���

%����Ϊ���Բ�����
m = 20;
n = 20;
source = 30;
ground = 40;

pairs = 2;
rate = 0.8;  %��Ŀ�꺯����Ȩ�ر����������㿪ʼǰ���û��趨��
threshold = 10000;  %��ѭ����ֹ���ԣ���ֹ������
temperature_iterations = 20;

figure('NumberTitle', 'off', 'Name', 'initial solution');
[ init_pinassign init_Lsum init_Dsum ]= initialsolution( m, n, source, ground );
init_Lsum
init_Dsum

figure('NumberTitle', 'off', 'Name', 'original');
beginning1 = cputime;
[ best_Lsum_orig best_Dsum_orig sa_result_orig final_temperature_orig ] = simulatedannealing_original(init_pinassign, pairs, rate,...
    m, n, source, ground)    %��ͨģ���˻��Ż�����
orig = cputime - beginning1

figure('NumberTitle', 'off', 'Name', 'rising');
beginning3 = cputime;
[ best_Lsum_ris best_Dsum_ris sa_result_ris final_temperature_ris ] = simulatedannealing_rising(init_pinassign, pairs, rate,...
    m, n, source, ground)    %����ģ���˻��Ż�����
ris = cputime - beginning3

figure('NumberTitle', 'off', 'Name', 'iteration');
beginning4 = cputime;
[ best_Lsum_ite best_Dsum_ite sa_result_ite final_temperature_ite ] = simulatedannealing_ite(init_pinassign, pairs, rate,...
    m, n, source, ground, threshold, temperature_iterations)    %��ֹģ���˻��Ż�����
ite = cputime - beginning4

figure('NumberTitle', 'off', 'Name', 'completed');
beginning5 = cputime;
[ best_Lsum best_Dsum sa_result final_temperature ] = simulatedannealing(init_pinassign, pairs, rate,...
    m, n, source, ground, threshold, temperature_iterations)    %����ģ���˻��Ż�����
com = cputime - beginning5

load chirp
sound(y,Fs)

clear