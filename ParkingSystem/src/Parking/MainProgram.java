package Parking;


import java.util.*;

import Parking.ConnectDB;

/**
 * 
 * @author yanuarwicaksana
 *
 * Comments: This class represent a helper function to be used on the jsp program. Because of some path problem, we can't changed
 * the name of this class to better representation.
 * 
 * 
 */
public class MainProgram {

	public static void InitParkingSpace(ParkingLot lot){
		for (int i = 1; i <= 30; i++){
			ParkingSpace space = new ParkingSpace(i);
			lot.addParkingSpace(space);
		}
	}
	
}
