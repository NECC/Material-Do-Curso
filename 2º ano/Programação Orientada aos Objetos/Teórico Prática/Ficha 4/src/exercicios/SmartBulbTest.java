/*********************************************************************************/
/** DISCLAIMER: Este código foi criado e alterado durante as aulas práticas      */
/** de POO. Representa uma solução em construção, com base na matéria leccionada */ 
/** até ao momento da sua elaboração, e resulta da discussão e experimentação    */
/** durante as aulas. Como tal, não deverá ser visto como uma solução canónica,  */
/** ou mesmo acabada. É disponibilizado para auxiliar o processo de estudo.      */
/** Os alunos são encorajados a testar adequadamente o código fornecido e a      */
/** procurar soluções alternativas, à medida que forem adquirindo mais           */
/** conhecimentos de POO.                                                        */
/*********************************************************************************/

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

/**
 * The test class SmartBulbTest.
 *
 * @author  (your name)
 * @version (a version number or a date)
 */
public class SmartBulbTest {
    /**
     * Default constructor for test class SmartBulbTest
     */
    public SmartBulbTest()
    {
    }

    /**
     * Sets up the test fixture.
     *
     * Called before every test case method.
     */
    @BeforeEach
    public void setUp()
    {
    }

    /**
     * Tears down the test fixture.
     *
     * Called after every test case method.
     */
    @AfterEach
    public void tearDown()
    {
    }

    @Test
    public void testContructor() {
        SmartBulb smartBul1 = new SmartBulb();
        assertTrue(smartBul1!=null);
        smartBul1 = new SmartBulb("b1");
        assertTrue(smartBul1!=null);
        smartBul1 = new SmartBulb("b1", SmartBulb.NEUTRAL);
        assertTrue(smartBul1!=null);
    }

    @Test
    public void testGetTone() {
        SmartBulb smartBul1 = new SmartBulb("b1", SmartBulb.COLD);
        assertEquals(0, smartBul1.getTone());
        smartBul1 = new SmartBulb("b1", SmartBulb.NEUTRAL);
        assertEquals(1, smartBul1.getTone());
        smartBul1 = new SmartBulb("b1", SmartBulb.WARM);
        assertEquals(2, smartBul1.getTone());
        smartBul1 = new SmartBulb("b1");
        assertEquals(SmartBulb.NEUTRAL, smartBul1.getTone());
    }

    @Test
    public void testSetTone() {
        SmartBulb smartBul1 = new SmartBulb("b1");
        smartBul1.setTone(2);
        assertEquals(SmartBulb.WARM, smartBul1.getTone());
        smartBul1.setTone(10);
        assertEquals(SmartBulb.WARM, smartBul1.getTone());
        smartBul1.setTone(-10);
        assertEquals(SmartBulb.COLD, smartBul1.getTone());
    }

}



