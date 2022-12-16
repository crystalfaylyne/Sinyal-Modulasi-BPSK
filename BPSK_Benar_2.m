clc
clear

% Parameter sinyal carrier
fc = 100;
Tc = 1/fc;
Ac = 1;

% Parameter sinyal informasi
bitdata = [0 1 1 0];
bitrate = 2.5;

%Mengatur Frekuensi sampling
fs=10*fc;
ts=1/fs;

%Membuat sinyal carrier
jumlah_bit = length(bitdata);
t_akhir = jumlah_bit/bitrate;
t = 0:ts:t_akhir;
lg_t = length(t);
t = t(1:lg_t-1);
Sc = Ac*cos(2*pi*fc*t);
figure
plot(t,Sc)
title('Sinyal Carrier');

%Membuat sinyal informasi
for i=1:jumlah_bit
    if(bitdata(i))==0
        sinyal_NRZ(i)=-1;
    else
        sinyal_NRZ(i)=1;
    end
end
sampleperbit = fs/bitrate;
Si = sinyal_NRZ(1)*ones(1,sampleperbit);
for i = 2:jumlah_bit
    S = sinyal_NRZ(i)*ones(1,sampleperbit);
    Si = [Si S]
end
figure
plot(t,Si)
title('Sinyal Informasi');

%Modulator BPSK
S_BPSK = Si.*Sc
figure
plot(t,S_BPSK)
title('Sinyal Modulator BPSK')