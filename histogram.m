clear;
clf;
clc;
plain=imread('./Input/monkey1.bmp');
cipher_image = imread('./Outputs/Encryption/enc_monkey1.bmp');

Red_plain = plain(:,:,1);
Green_plain = plain(:,:,2);
Blue_plain = plain(:,:,3);
Red_cipher=cipher_image(:,:,1);
Green_cipher=cipher_image(:,:,2);
Blue_cipher=cipher_image(:,:,3);

entropy_red = entropy(Red_plain);
entropy_green = entropy(Green_plain);
entropy_blue = entropy(Blue_plain);
entropy_cipher_red = entropy(Red_cipher);
entropy_cipher_green = entropy(Green_cipher);
entropy_cipher_blue = entropy(Blue_cipher);

R_red = corr2(Red_cipher,Red_plain);
R_green = corr2(Green_cipher,Green_plain);
R_blue = corr2(Blue_cipher,Blue_plain);

fprintf("Correlation Coefficient for red values in plain image vs cipher image: %3.4f\n",R_red);
fprintf("Correlation Coefficient for green values in plain image vs cipher image: %3.4f\n",R_green);
fprintf("Correlation Coefficient for blue values in plain image vs cipher image: %3.4f\n",R_blue);
fprintf("Entropy of red channel (Plain Image): %3.4f\n", entropy_red);
fprintf("Entropy of green channel (Plain Image): %3.4f\n", entropy_green);
fprintf("Entropy of blue channel (Plain Image): %3.4f\n", entropy_blue);
fprintf("Entropy of red channel (Cipher Image): %3.4f\n", entropy_cipher_red);
fprintf("Entropy of green channel (Cipher Image): %3.4f\n", entropy_cipher_green);
fprintf("Entropy of blue channel (Cipher Image): %3.4f\n", entropy_cipher_blue);

[yRed, x] = imhist(Red_plain);
[yGreen, x] = imhist(Green_plain);
[yBlue, x] = imhist(Blue_plain);
[yRed_cipher, x] = imhist(Red_cipher);
[yBlue_cipher, x] = imhist(Blue_cipher);
[yGreen_cipher, x] = imhist(Green_cipher);

fprintf("Entropy difference (Red Channel) %3.4f\n",entropy_red-entropy_cipher_red);
fprintf("Entropy difference (Green Channel) %3.4f\n",entropy_green-entropy_cipher_green);
fprintf("Entropy difference (Blue Channel) %3.4f\n",entropy_blue-entropy_cipher_blue);
figure(1);
bar(yRed, 'Red') ,hold on , bar(yGreen, 'Green'), hold on ,bar( yBlue, 'Blue');
legend('Red Value','Green Value','Blue Value');
xlabel("RGB Value (0-255)");
ylabel("# Occurrences");
xlim([0,255]);
title("Plain Image Histogram");

figure(2);
bar(yRed_cipher, 'Red') ,hold on , bar(yGreen_cipher, 'Green'), hold on ,bar( yBlue_cipher, 'Blue');
legend('Red Value','Green Value','Blue Value');
xlabel("RGB Value (0-255)");
ylabel("# Occurrences");
xlim([0,255]);
title("Cipher Image Histogram");