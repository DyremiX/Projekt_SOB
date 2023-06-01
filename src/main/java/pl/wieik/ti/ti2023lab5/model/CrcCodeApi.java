package pl.wieik.ti.ti2023lab5.model;

public class CrcCodeApi {
    public static String encodeData(String data) {
        // Polynomial divisor
        String divisor = "1011";

        // Append zeros to data based on the degree of the polynomial divisor
        String appendedData = data + "000";

        char[] dividend = appendedData.toCharArray();
        char[] tempDividend = new char[divisor.length()];

        for (int i = 0; i < divisor.length(); i++) {
            tempDividend[i] = dividend[i];
        }

        for (int i = 0; i < data.length(); i++) {
            if (tempDividend[0] == '1') {
                for (int j = 1; j < divisor.length(); j++) {
                    if (tempDividend[j] == divisor.charAt(j)) {
                        tempDividend[j - 1] = '0';
                    } else {
                        tempDividend[j - 1] = '1';
                    }
                }
            } else {
                for (int j = 1; j < divisor.length(); j++) {
                    if (tempDividend[j] == '1') {
                        tempDividend[j - 1] = '1';
                    } else {
                        tempDividend[j - 1] = '0';
                    }
                }
            }
            if (i != data.length() - 1) {
                tempDividend[divisor.length() - 1] = dividend[i + divisor.length()];
            }
        }

        String crcCode = "";
        for (int i = 0; i < tempDividend.length; i++) {
            crcCode += tempDividend[i];
        }

        return data + crcCode;
    }
}
