# aeon_reports
tools and reminders for recurring aeon reporting needs

### Data export and data cleaning
- in the db export settings, quote all lines
- in a regex-enabled editor (e.g. oXygen), find/replace:
    - \n{2,}
    - (\n)(^",)
    - \n\s{2,}
    - (\n)([^"])
- QA: check for presence of "," in Transaction ID

### Data import to a visual editor (e.g. Excel)
- open a new file
- File > Import
- UTF-8, comma-delimited
   - change data type to Text on identifiers (barcodes, mmsids etc.)
   - change data type to Date on date columns
 
### Matching on identifiers
- use identifiers as recorded in the originating systems
- create a helper column concatenating CallNumber and Sublocation
- as appropriate, split Aeon columns on `;`, `,`, ` `, `(`, `/`, `_` (if needed for cid's)
- dedupe the input list
- normalize (downcase; TRIM leading and trailing spaces) before attempting a match

### Match points
Which identifiers map to which Aeon field has changed over time. Therefore, attempt to match all identifiers against any column that (may) contain an identifier. Possible match points are:

| Aeon | Alma | EAD | other |
| ---- | ---- | ---- | ---- |
| ItemNumber | Barcode | cid |
| CallNumber | Permanent Call Number | eadid |
| ReferenceNumber | mmsid | cid [multiple] | SCSB |
| ReferenceNumber | Originating System Number [normalized] | | |	
| ItemNumber | Originating System Number [normalized] | | | 	
| CallNumber | Originating System Number | | | 	
| EADNumber | | | blanks or "EADRequest"
