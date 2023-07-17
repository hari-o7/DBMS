const form = document.getElementById("myForm");

form.addEventListener("submit", (e) => {
  e.preventDefault(); // Prevent the default form submission

  // Retrieve the form data
  const name = document.getElementById("name").value;
  const rollNo = document.getElementById("rollNo").value;
  const clz = document.getElementById("clz").value;

  // Create an object with the form data
  const formData = {
    name: name,
    rollNo: rollNo,
    clz: clz,
  };

  // Make an HTTP POST request to the backend endpoint
  fetch("http://localhost:3000/submit-form", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    mode: "cors", // Set the 'mode' option to 'cors'
    body: JSON.stringify(formData),
  })
    .then((response) => {
      if (response.ok) {
        console.log("Form submitted successfully");
        // Handle success
      } else {
        console.error("Form submission failed");
        // Handle failure
      }
    })
    .catch((error) => {
      console.error("Error:", error);
      // Handle error
    });
});
