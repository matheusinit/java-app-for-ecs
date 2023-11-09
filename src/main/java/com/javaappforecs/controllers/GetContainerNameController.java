package com.javaappforecs.controllers;

import com.javaappforecs.data.HostName;
import java.net.InetAddress;
import java.net.UnknownHostException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class GetContainerNameController {

  @GetMapping("/host-name")
  ResponseEntity<?> getContainerName() throws UnknownHostException {
    var hostname = InetAddress.getLocalHost().getHostName();

    var hostNameObject = new HostName(hostname);

    return ResponseEntity.status(HttpStatus.OK).body(hostNameObject);
  }
}
