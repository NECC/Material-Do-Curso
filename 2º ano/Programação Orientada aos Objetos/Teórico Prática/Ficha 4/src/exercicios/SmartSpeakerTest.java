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
 * The test class SmartSpeakerTest.
 *
 * @author  (your name)
 * @version (a version number or a date)
 */
public class SmartSpeakerTest {
    /**
     * Default constructor for test class SmartSpeakerTest
     */
    public SmartSpeakerTest()
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
    public void testConstructor() {
        SmartSpeaker smartSpe1 = new SmartSpeaker();
        assertTrue(smartSpe1!=null);
        smartSpe1 = new SmartSpeaker("b1");
        assertTrue(smartSpe1!=null);
        smartSpe1 = new SmartSpeaker("b1", "RUM", 5);
        assertTrue(smartSpe1!=null);
    }

    @Test
    public void testGetVolume() {
        SmartSpeaker smartSpe1 = new SmartSpeaker("s1", "RUM", 5);
        assertEquals(5, smartSpe1.getVolume());
        smartSpe1 = new SmartSpeaker("b1", "RUM", SmartSpeaker.MAX);
        assertEquals(20, smartSpe1.getVolume());
        smartSpe1 = new SmartSpeaker("b1", "RUM", -10);
        assertEquals(0, smartSpe1.getVolume());
        smartSpe1 = new SmartSpeaker();
        assertEquals(0, smartSpe1.getVolume());
    }

    @Test
    public void testSetVolume() {
        SmartSpeaker smartSpe1 = new SmartSpeaker("s1", "RUM", 5);
        smartSpe1.volumeUp();
        smartSpe1.volumeUp();
        assertEquals(7, smartSpe1.getVolume());
        for (int i=0; i<25; i++) smartSpe1.volumeUp();
        assertEquals(20, smartSpe1.getVolume());
        for (int i=0; i<30; i++) smartSpe1.volumeDown();
        assertEquals(0, smartSpe1.getVolume());
    }

    @Test
    public void testGetChannel() {
        SmartSpeaker smartSpe1 = new SmartSpeaker("s1", "RUM", 5);
        assertEquals("RUM", smartSpe1.getChannel());
        smartSpe1 = new SmartSpeaker("s2", "XPTO", 5);
        assertEquals("XPTO", smartSpe1.getChannel());
        smartSpe1 = new SmartSpeaker();
        assertEquals("", smartSpe1.getChannel());
    }

    @Test
    public void testSetChannel() {
        SmartSpeaker smartSpe1 = new SmartSpeaker("s1");
        smartSpe1.setChannel("RUM");
        assertEquals("RUM", smartSpe1.getChannel());
        smartSpe1.setChannel("XPTO");
        assertEquals("XPTO", smartSpe1.getChannel());
    }
}

