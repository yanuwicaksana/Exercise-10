/*
 * Unit testing for parking map's get direction.
 */

package Parking;

import static org.junit.Assert.*;

import org.junit.Test;

public class mapunittesting {

	@Test
	public void test() {
		ParkingLot lot = new ParkingLot();
		MainProgram.InitParkingSpace(lot);
		
		// Check in at space 2
		ParkingMap map = new ParkingMap(lot);
		lot.checkin(new ParkingSpace(2));
		String test1 = map.getdirection();
		String expected1 = "1 1"; // Space 1 is available
		
		assertEquals(test1, expected1);
		
		// Check in at space 1
		lot.checkin(new ParkingSpace(1));
		String test2 = map.getdirection();
		String expected2 = "1 3"; // Space 3 is available
		
		assertEquals(test2, expected2);
		
		
		// Check out from space 2
		lot.checkout(new ParkingSpace(2));
		String test3 = map.getdirection();
		String expected3 = "1 2"; // Space 2 is available
		
		assertEquals(test3, expected3);
		
		// Check in at space 3
		lot.checkin(new ParkingSpace(3));
		String test4 = map.getdirection();
		String expected4 = "1 2"; // Space 2 is available
		
		assertEquals(test4, expected4);
	}

}
