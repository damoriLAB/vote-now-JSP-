package com.zzorg.model;
import lombok.Builder;


import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Builder
@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
public class Survey {

	Integer id;

	String title;
	String description;
	User user;
	List<Option> options;
	SurveyStatus status;
	LocalDateTime createdAt;
	LocalDateTime updatedAt;
	


	
    // TODO : remove this method
    public String getFormattedCreatedAt() {
        if (createdAt != null) {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm dd-MM-yyyy");
            return createdAt.format(formatter);
        }
        return null;
    }
	
}
