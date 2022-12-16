clc
clear

bitdata = [1 1 0 0 1];
bitrate = 5; %jumlah bit per second (bps)

%membuat nilai NRZ
%NRZ Encoder
%fungsinya untuk mengkonversi nilai bit menjadi sinyal informasi
%nilai bit 1 tetap menjadi 1, nilai bit 0 akan menjadi -1
jumlah_bit = length(bitdata);
for i=1:jumlah_bit %angka nya 6, karena data nya 6
    if(bitdata(i)==0)
        NRZ_out(i)=-1;
    else
        NRZ_out(i)=1;
    end
end    

Ac = 1;
Fc = 20;

Fs = 10*Fc; %nilai frekuensi sampling disini minimal harus >=2x dari frekuensi
%arti frekuensi sampling = banyaknya sample dalam 1 detik
Ts = 1/Fs;

%buat sinyal NRZ
%s1 = 1*ones(1,Fs/bitrate);
%s2 = 1*ones(1,Fs/bitrate);
%s3 = -1*ones(1,Fs/bitrate);
%s4 = -1*ones(1,Fs/bitrate);
%si =[s1 s2 s3 s4]

si = NRZ_out(1)*ones(1,Fs/bitrate);

for i = 2:jumlah_bit
    s = NRZ_out(i)*ones(1,Fs/bitrate);
    si = [si s];
end
%si digunakan untuk menggabungkan sinyal s1, s2, s3, s4

t = 0:Ts:jumlah_bit/bitrate; %nilai 3 disini dapat diganti dengan nilai lain (karna dia terserah nilainya)
length_t = length(t);
t = t(1:length_t-1); % untuk motong t
%sinyal informasi
%Si = Ai*sin(2*pi*Fi*t);
figure
plot(t, si)
title('Sinyal Informasi')

%sinyal carrier
Sc = Ac*sin(2*pi*Fc*t);
figure
plot(t, Sc)
title('Sinyal Carrier')

S_BPSK = si.*Sc;
figure
plot(t,S_BPSK)
title('Sinyal Modulasi BPSK')

%proses demodulator
S_dt = S_BPSK.*Sc;
figure 
plot(t, S_dt)
title('Hasil Perkalian Sinyal Modulasi BPSK dan Carrier (Demodulator)') %pada figure 4 masih ada frekuensi tinggi, jadi baal digunakan LPF untuk menghilangkan sinyal frekuensi tinggi tersebut