package com.lucy.lms;

import com.lucy.lms.controller.RoomWebController;
import com.lucy.lms.entity.*;
import com.lucy.lms.repository.*;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class LucyLmsApplicationTests {

	@Autowired
	private RoomWebController roomWebController;

	@Autowired
	private RoomRepository roomRepository;

	@Autowired
	private JoinRequestRepository joinRequestRepository;

	@Autowired
	private GiftTransactionRepository giftTransactionRepository;

	@Autowired
	private PodcastEpisodeRepository podcastEpisodeRepository;

	@Autowired
	private RoomParticipantRepository participantRepository;

	@Autowired
	private PinnedMaterialRepository pinnedMaterialRepository;

	@Test
	void contextLoads() {
	}

	@Test
	void testEndScheduledRoom() {
		Room room = new Room();
		room.setTitle("Test Scheduled Room");
		room.setStatus("SCHEDULED");
		room = roomRepository.save(room);
		Long roomId = room.getId();
		assertNotNull(roomId);

		// 1. Create a JoinRequest
		JoinRequest jr = new JoinRequest();
		jr.setRoom(room);
		jr.setStatus("PENDING");
		jr = joinRequestRepository.save(jr);
		Long jrId = jr.getId();
		assertNotNull(jrId);

		// 2. Create a RoomParticipant
		RoomParticipant rp = new RoomParticipant();
		rp.setRoom(room);
		rp.setDisplayName("Test Participant");
		rp = participantRepository.save(rp);
		Long rpId = rp.getId();
		assertNotNull(rpId);

		// 3. Create PinnedMaterial
		PinnedMaterial pm = new PinnedMaterial();
		pm.setRoom(room);
		pm.setTitle("Test Material");
		pm = pinnedMaterialRepository.save(pm);
		Long pmId = pm.getId();
		assertNotNull(pmId);

		// 4. Create GiftTransaction
		GiftTransaction gt = new GiftTransaction();
		gt.setRoom(room);
		gt = giftTransactionRepository.save(gt);
		Long gtId = gt.getId();
		assertNotNull(gtId);

		// 5. Create PodcastEpisode
		PodcastEpisode pe = new PodcastEpisode();
		pe.setRoom(room);
		pe.setTitle("Test Episode");
		pe = podcastEpisodeRepository.save(pe);
		Long peId = pe.getId();
		assertNotNull(peId);

		// Call endRoom
		String result = roomWebController.endRoom(roomId);
		assertEquals("redirect:/rooms", result);

		// Assertions
		// Room should be deleted
		assertFalse(roomRepository.findById(roomId).isPresent());

		// RoomParticipant, PinnedMaterial, JoinRequest should be deleted
		assertFalse(participantRepository.findById(rpId).isPresent());
		assertFalse(pinnedMaterialRepository.findById(pmId).isPresent());
		assertFalse(joinRequestRepository.findById(jrId).isPresent());

		// GiftTransaction and PodcastEpisode should still exist but room reference should be null
		GiftTransaction updatedGt = giftTransactionRepository.findById(gtId).orElse(null);
		assertNotNull(updatedGt);
		assertNull(updatedGt.getRoom());

		PodcastEpisode updatedPe = podcastEpisodeRepository.findById(peId).orElse(null);
		assertNotNull(updatedPe);
		assertNull(updatedPe.getRoom());
	}
}
