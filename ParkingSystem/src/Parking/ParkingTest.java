package Parking;

import static org.junit.Assert.*;

import org.junit.Test;

public class ParkingTest {

	@Test
	public void test() {
		ParkingLot lot = new ParkingLot();
		InitParkingSpace(lot);
		lot.checkavailable();
		
		int ava = lot.getavailablespace();
		int guess = 0;
		for (int i = 0; i< lot.getparkinglist().size(); i++){
			ParkingSpace space = (ParkingSpace) lot.getparkinglist().get(i);
			if(space.getAvailability()) guess += 1;
		}
		assertEquals(ava,guess);
		
		lot.checkin(new ParkingSpace(1));
		int ava2 = lot.getavailablespace();
		assertEquals(ava2,29);
		
		lot.checkout(new ParkingSpace(1));
		int ava3 = lot.getavailablespace();
		assertEquals(ava3,30);
		
		ParkingSpace testspace = new ParkingSpace(31);
		lot.addParkingSpace(testspace);
		assertTrue(lot.getparkinglist().contains(testspace));
		
		lot.addParkingSpace(testspace);
		int ava4 = lot.getavailablespace();
		assertEquals(ava4,31);
	}
	
	public static void InitParkingSpace(ParkingLot lot){
		for (int i = 1; i <= 30; i++){
			ParkingSpace space = new ParkingSpace(i);
			lot.addParkingSpace(space);
		}
	}
}
