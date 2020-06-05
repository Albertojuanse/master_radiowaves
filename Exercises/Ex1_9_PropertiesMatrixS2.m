clc; clear all; close all;
%% Exercise 9
% Sean las matrices SA y SB, indicar sus propiedades

Sa = [0.1552 + 0.2987i  -0.2286 + 0.0755i  -0.3031 + 0.2264i   0.6480 + 0.1155i  -0.4776 + 0.1557i;
      0.5295 + 0.2099i  -0.1646 - 0.2973i   0.5739 - 0.0732i  -0.0589 + 0.4068i   0.0316 + 0.2356i;
     -0.6522 - 0.0876i   0.1871 - 0.1000i   0.4798 + 0.0100i   0.4598 + 0.1482i   0.0637 + 0.2330i;
      0.2489 + 0.0848i   0.5771 - 0.1838i  -0.3225 + 0.1566i   0.2894 + 0.2256i   0.5481 - 0.0204i;
      0.0920 - 0.2273i   0.4376 - 0.4724i  -0.1487 - 0.3758i  -0.0539 - 0.1641i  -0.4992 + 0.2876i;
     ]; 
 
Sb = [-0.3100 - 0.5033i   0.2924 - 0.1696i  -0.4621 + 0.0789i  -0.2604 - 0.0741i  -0.1098 - 0.0068i;
       0.2924 - 0.1696i  -0.1266 - 0.1602i   0.0078 + 0.0840i  -0.2416 + 0.5878i   0.2536 - 0.3147i;
      -0.4621 + 0.0789i   0.0078 + 0.0840i  -0.0059 - 0.1356i  -0.0392 - 0.1583i   0.3113 - 0.6046i;
      -0.2604 - 0.0741i  -0.2416 + 0.5878i  -0.0392 - 0.1583i  -0.4353 + 0.0476i  -0.0304 + 0.2095i;
      -0.1098 - 0.0068i   0.2536 - 0.3147i   0.3113 - 0.6046i  -0.0304 + 0.2095i  -0.2164 + 0.0479i
      ];
S = Sb;
  
fprintf('The matrix S obteined is matched: %s\n',mat2str(isMatched(S)));
fprintf('The matrix S obteined is reciprocal: %s\n',mat2str(isReciprocal(S)));
fprintf('The matrix S obteined is pasive: %s\n',mat2str(isPasive(S)));
fprintf('The matrix S obteined is lossless: %s\n',mat2str(isLossless(S)));
fprintf('The matrix S obteined is pasive and lossless: %s\n',mat2str(isPassiveAndLossless(S)));