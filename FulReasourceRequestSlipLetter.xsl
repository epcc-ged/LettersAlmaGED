<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- This file: FulReasourceRequestSlipLetter.xsl -->

<xsl:include href="header.xsl" />
<xsl:include href="senderReceiver.xsl" />
<xsl:include href="mailReason.xsl" />
<xsl:include href="footer.xsl" />
<xsl:include href="style.xsl" />
<xsl:include href="recordTitle.xsl" />
<xsl:template match="/">
	<html>
		<head>
		<xsl:call-template name="generalStyle" />
		</head>

		<body>
			<!-- remove header with logo, letter name and date
			<xsl:call-template name="head" /> header.xsl 
			-->
			<!-- add table with substitute header 
				letter name
				user name
				date
			-->
			<table cellspacing="0" cellpadding="5" border="0">
				<xsl:attribute name="style">
					<xsl:call-template name="headerTableStyleCss" /> <!-- style.xsl -->
				</xsl:attribute>
				<tr>
					<xsl:for-each select="notification_data/general_data">
						<td>
							<h1><xsl:value-of select="letter_name"/></h1>
						</td>
						<td align="right">
							<xsl:value-of select="current_date"/>
						</td>
					</xsl:for-each>
				</tr>
				<!-- USER STARTS HERE -->
				<tr>
					<td>
					<xsl:if test="notification_data/user_for_printing/name">
						<h1>
							<xsl:value-of select="notification_data/user_for_printing/name"/>
							<xsl:if test="notification_data/user_for_printing/user_group">
								&#160;[<xsl:value-of select="notification_data/user_for_printing/user_group"/>]
							</xsl:if>
						</h1>
						<!-- nicomo: we hide the user's personal information as
						this printed slip is put in the book and then into public shelves 
						<xsl:if test="notification_data/user_for_printing/phone != ''" >
							<p>tél: <xsl:value-of select="notification_data/user_for_printing/phone"/></p>
						</xsl:if>
						<xsl:if test="notification_data/user_for_printing/email != ''" >
							<p>email: <xsl:value-of select="notification_data/user_for_printing/email"/></p>
						</xsl:if>
						<p>Identifiants :</p>
						<ul> 
							<xsl:for-each select="notification_data/user_for_printing/identifiers/code_value">
								<li><xsl:value-of select="value"/></li>
							</xsl:for-each>
						</ul>
						end of user personal information -->
					</xsl:if>
					</td>
				</tr>
				<!-- END OF USER INFO -->
			</table>
			
			<div class="messageArea">
				<div class="messageBody">
					<table cellspacing="0" cellpadding="5" border="0">
						<!-- BEGINNING OF DOC INFORMATION -->
						<tr>
							<td>
								<h3><xsl:call-template name="recordTitle" /></h3>
								<xsl:if test="notification_data/phys_item_display/isbn != ''">
									<p>@@isbn@@: <xsl:value-of select="notification_data/phys_item_display/isbn"/></p>
								</xsl:if>
								<xsl:if test="notification_data/phys_item_display/issn != ''">
									<p>@@issn@@: <xsl:value-of select="notification_data/phys_item_display/issn"/></p>
								</xsl:if>
								<xsl:if test="notification_data/phys_item_display/edition != ''">
									<p>@@edition@@: <xsl:value-of select="notification_data/phys_item_display/edition"/></p>
								</xsl:if>
								<xsl:if test="notification_data/phys_item_display/imprint != ''">
									<p>@@imprint@@: <xsl:value-of select="notification_data/phys_item_display/imprint"/></p>
								</xsl:if>
								<!-- Cote GED. Supprimer après déménagement. nicomo 2020-01-16 -->
								<xsl:if test="notification_data/phys_item_display/permanent_location != ''">
									<p>Localisation définitive: <xsl:value-of select="notification_data/phys_item_display/permanent_location"/></p>
								</xsl:if>
							</td>
							<td style="border:solid 2px #060">
								<h2>
									<b>@@location@@: </b><xsl:value-of select="notification_data/phys_item_display/location_name"/>
									<!-- nicomo : test si la localisation est au magasin distant IENA alors affichier
									loc + IENA, sinon afficher loc + CTLES
									-->
									<!-- this is not xslt2 but xslt1, we can't do $name = ('Alice', 'Bob', 'Cindy'), repeating when -->
									<!-- TODO: SUPPRIMER APRES DEMENAGEMENT DES COLLECTIONS AU GED -->
									<xsl:choose>
										<xsl:when test="notification_data/phys_item_display/location_code='IRHT'"> (IENA)</xsl:when>
										<xsl:when test="notification_data/phys_item_display/location_code='IRHT_DOC'">Doc Assoc. IRHT</xsl:when>
										<xsl:when test="notification_data/phys_item_display/location_code='BUREAUX'">MSH PN</xsl:when>
										<xsl:otherwise> (CTLES)</xsl:otherwise>
									</xsl:choose>
									<!-- fin de test magasin distant -->
								</h2>
								<xsl:if test="notification_data/phys_item_display/call_number != ''">
									<h2><b>@@call_number@@: </b><xsl:value-of select="notification_data/phys_item_display/call_number"/></h2>
								</xsl:if>	
								<xsl:if test="notification_data/phys_item_display/accession_number != ''">
									<h2><b>@@accession_number@@: </b><xsl:value-of select="notification_data/phys_item_display/accession_number"/></h2>
								</xsl:if>
								<!-- barcode -->
								<!--  
									- test field phys_item_display/barcode 
									- sinon affiche tous les barcodes des items existant
								-->
								<xsl:choose>
									<xsl:when test="notification_data/phys_item_display/barcode != ''">
										<b>Code-barres: <xsl:value-of select="notification_data/phys_item_display/barcode"/></b>
									</xsl:when>
									<xsl:when test="notification_data/phys_item_display/available_items">
										<xsl:for-each select="notification_data/phys_item_display/available_items/available_item">
											<b>Code-barres: <xsl:value-of select="barcode"/></b><br/>
										</xsl:for-each>
									</xsl:when>
								</xsl:choose>
								<!-- patron note -->
								<xsl:if test="notification_data/request/note != ''">
									<br/><b>@@request_note@@: <xsl:value-of select="notification_data/request/note"/></b>
								</xsl:if>
							</td>
						</tr>
						<xsl:if  test="notification_data/request/selected_inventory_type='ITEM'" >
							<tr>
								<td><b>@@note_item_specified_request@@.</b></td>
							</tr>
						</xsl:if>
						<xsl:if  test="notification_data/request/manual_description != ''" >
							<tr>
								<td><b>@@please_note@@: </b>@@manual_description_note@@ - <xsl:value-of select="notification_data/request/manual_description"/></td>
							</tr>
						</xsl:if>
						<!-- BARCODE -->
						<tr>
							<!-- CODE BARRES DE LA REQUETE -->
							<td>
								<b>@@request_id@@</b><br/>
								<img src="cid:request_id_barcode.png" alt="Request Barcode"/>
							</td>
							<!-- CODE BARRES DE L'EXEMPLAIRE SPECIFIQUE -->
							<td>
								<xsl:if  test="notification_data/request/selected_inventory_type='ITEM'" >
									<b>@@item_barcode@@</b><br />
									<img src="cid:item_id_barcode.png" alt="Request Barcode"/>
								</xsl:if>
							</td>
						</tr>
						<xsl:if  test="notification_data/external_id != ''" >
							<tr>
								<td><b>@@external_id@@: </b><xsl:value-of select="notification_data/external_id"/></td>
							</tr>
						</xsl:if>
						<xsl:if  test="notification_data/phys_item_display/shelving_location/string" >
							<xsl:if  test="notification_data/request/selected_inventory_type='ITEM'" >
							<tr>
								<td><b>@@shelving_location_for_item@@: </b>
								 <xsl:for-each select="notification_data/phys_item_display/shelving_location/string">
									<xsl:value-of select="."/>
								 &#160;
								 </xsl:for-each>
								</td>
							</tr>
							</xsl:if>
							<xsl:if  test="notification_data/request/selected_inventory_type='HOLDING'" >
							<tr>
								<td><b>@@shelving_locations_for_holding@@: </b>
								<xsl:for-each select="notification_data/phys_item_display/shelving_location/string">
									<xsl:value-of select="."/>
								&#160;
								 </xsl:for-each>
								</td>
							</tr>
							</xsl:if>
							<xsl:if  test="notification_data/request/selected_inventory_type='VIRTUAL_HOLDING'" >
							<tr>
								<td><b>@@shelving_locations_for_holding@@: </b>
								<xsl:for-each select="notification_data/phys_item_display/shelving_location/string">
									<xsl:value-of select="."/>
								&#160;
								 </xsl:for-each>
								</td>
							</tr>
							</xsl:if>
						</xsl:if>
						<xsl:if  test="notification_data/phys_item_display/display_alt_call_numbers/string" >
							<xsl:if  test="notification_data/request/selected_inventory_type='ITEM'" >
							<tr>
								<td><b>@@alt_call_number@@: </b>
								 <xsl:for-each select="notification_data/phys_item_display/display_alt_call_numbers/string">
									<xsl:value-of select="."/>
								 &#160;
								 </xsl:for-each>
								</td>
							</tr>
							</xsl:if>
							<xsl:if  test="notification_data/request/selected_inventory_type='HOLDING'" >
							<tr>
								<td><b>@@alt_call_number@@: </b>
								<xsl:for-each select="notification_data/phys_item_display/display_alt_call_numbers/string">
									<xsl:value-of select="."/>
								&#160;
								 </xsl:for-each>
								</td>
							</tr>
							</xsl:if>
							<xsl:if  test="notification_data/request/selected_inventory_type='VIRTUAL_HOLDING'" >
							<tr>
								<td><b>@@alt_call_number@@: </b>
								<xsl:for-each select="notification_data/phys_item_display/display_alt_call_numbers/string">
									<xsl:value-of select="."/>
								&#160;
								 </xsl:for-each>
								</td>
							</tr>
							</xsl:if>
						</xsl:if>
						<!-- nicomo : inutile, nous n'avons qu'une seule bibliothèque 
						<tr>
							<td><b>@@move_to_library@@: </b><xsl:value-of select="notification_data/destination"/></td>
						</tr>
						-->
						<tr>
							<td><b>@@request_type@@: </b><xsl:value-of select="notification_data/request_type"/></td>
						</tr>
						<xsl:if test="notification_data/request/system_notes != ''">
							<tr>
								<td><b>@@system_notes@@:</b><xsl:value-of select="notification_data/request/system_notes"/></td>
							</tr>
						</xsl:if>
					</table>
				</div>
			</div>
			<xsl:call-template name="lastFooter" /> <!-- footer.xsl -->
		</body>
	</html>
</xsl:template>
</xsl:stylesheet>
