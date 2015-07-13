#epp-br

**epp-br** is a ruby epp client for the brazillian(.br) registrar registro.br.

---

###### Built on top of the epp-client implementation, it provides:
- a simpler interface to the epp-client
- the brorg(organization) extension required by registro.br

---

###### Tests
Tests are run against the registro.br test host beta.registro.br. Altough this is a very unorthodox way of performing tests (not isolated, depending on an external service) is straightforward. Since all the XML consistency is tested in the epp-client gem, of which this one depends entirely in this matter, the most imporant thing that rests to us to test is if it's working according with the singularities of registro.br. 
