package com.zzorg.model;

import lombok.Builder;

import java.time.LocalDateTime;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Builder
@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
public class User {
	Integer id;
	String name;
	String username;
	String email;
	String iconURL;
	@JsonIgnore
	String password;
	LocalDateTime createdAt;
	LocalDateTime updateAt;
}
