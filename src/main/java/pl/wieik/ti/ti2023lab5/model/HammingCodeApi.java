package pl.wieik.ti.ti2023lab5.model;
// import java.util.*;

public class HammingCodeApi {

    public static int calculateParityBits(int inputLength) {
        int parityBits = 0;
        while (inputLength + parityBits + 1 > Math.pow(2, parityBits)) {
            parityBits++;
        }
        return parityBits;
    }

    public static int[] convertStringToIntArray(String input) {
        int[] array = new int[input.length()];
        for (int i = 0; i < input.length(); i++) {
            array[i] = Integer.parseInt(String.valueOf(input.charAt(i)));
        }
        return array;
    }

    public static String convertIntArrayToString(int[] array) {
        StringBuilder sb = new StringBuilder();
        for (int i : array) {
            sb.append(i);
        }
        return sb.toString();
    }

    public static int[] getHammingCode(int data[]) {
        // declare an array that will store the hamming code for the data
        int returnData[];
        int size;
        // code to get the required number of parity bits
        int i = 0, parityBits = 0 ,j = 0, k = 0;
        size = data.length;
        while(i < size) {
            // 2 power of parity bits must equal to the current position(number of bits traversed + number of parity bits + 1).
            if(Math.pow(2, parityBits) == (i + parityBits + 1)) {
                parityBits++;
            }
            else {
                i++;
            }
        }

        // the size of the returnData is equal to the size of the original data + the number of parity bits.
        returnData = new int[size + parityBits];

        // for indicating an unset value in parity bit location, we initialize returnData array with '2'

        for(i = 1; i <= returnData.length; i++) {
            // condition to find parity bit location
            if(Math.pow(2, j) == i) {

                returnData[(i - 1)] = 2;
                j++;
            }
            else {
                returnData[(k + j)] = data[k++];
            }
        }
        // use for loop to set even parity bits at parity bit locations
        for(i = 0; i < parityBits; i++) {

            returnData[((int) Math.pow(2, i)) - 1] = getParityBit(returnData, i);
        }

        return returnData;
    }

    public static int getParityBit(int returnData[], int pow) {
        int parityBit = 0;
        int size = returnData.length;

        for(int i = 0; i < size; i++) {

            // check whether returnData[i] contains an unset value or not
            if(returnData[i] != 2) {

                // if not, we save the index in k by increasing 1 in its value

                int k = (i + 1);

                // convert the value of k into binary
                String str = Integer.toBinaryString(k);

                //Now, if the bit at the 2^(power) location of the binary value of index is 1,
                // we check the value stored at that location. If the value is 1 or 0,
                // we will calculate the parity value.

                int temp = ((Integer.parseInt(str)) / ((int) Math.pow(10, pow))) % 10;
                if(temp == 1) {
                    if(returnData[i] == 1) {
                        parityBit = (parityBit + 1) % 2;
                    }
                }
            }
        }
        return parityBit;
    }

    public static int[] receiveData(int data[], int parityBits) {

        // declare variable pow, which we use to get the correct bits to check for parity.
        int pow;
        int size = data.length;
        // declare parityArray to store the value of parity check
        int parityArray[] = new int[parityBits];
        // we use errorLoc string for storing the integer value of the error location.
        String errorLoc = new String();
        // use for loop to check the parities
        for(pow = 0; pow < parityBits; pow++) {
            // use for loop to extract the bit from 2^(power)
            for(int i = 0; i < size; i++) {
                // convert the value of j into binary
                String str = Integer.toBinaryString(i + 1);
                // find bit by using str
                int bit = ((Integer.parseInt(str)) / ((int) Math.pow(10, pow))) % 10;
                if(bit == 1) {
                    if(data[i] == 1) {
                        parityArray[pow] = (parityArray[pow] + 1) % 2;
                        // System.out.print("Dla i = " + i + ", pow = " + pow  + ", partiyarray = " + parityArray[pow]);
                    }
                }
            }
            errorLoc = parityArray[pow] + errorLoc;
            // System.out.print(errorLoc);
        }
        // This gives us the parity check equation values.
        // Using these values, we will now check if there is a single bit error and then correct it.
        // errorLoc provides parity check eq. values which we use to check whether a single bit error is there or not
        // if present, we correct it
        int finalLoc = Integer.parseInt(errorLoc, 2);
        // check whether the finalLoc value is 0 or not
        if(finalLoc != 0) {
            System.out.println("Error is found at location " + finalLoc + ".");
            data[finalLoc - 1] = (data[finalLoc - 1] + 1) % 2;
            System.out.println("After correcting the error, the code is:");
            for(int i = 0; i < size; i++) {
                System.out.print(data[size - i - 1]);
            }
            System.out.println();
        }
        else {
            System.out.println("There is no error in the received data.");
        }
        // print the original data
        System.out.println("The data sent from the sender:");
        int finalCode[] = new int[data.length - parityBits];
        int x = 0;
        pow = parityBits - 1;
        for(int k = size; k > 0; k--) {
            if(Math.pow(2, pow) != k) {
                // System.out.print(data[k - 1]);
                finalCode[finalCode.length - x - 1] = data[k - 1];
                x++;
            }
            else {
                // decrement value of pow
                pow--;
            }
        }
        // System.out.println();   // for next line
        for (int k = 0 ; k < finalCode.length ; k++) {
            System.out.print(finalCode[k]);
        }
        System.out.println();   // for next line
        return finalCode;
    }

}
