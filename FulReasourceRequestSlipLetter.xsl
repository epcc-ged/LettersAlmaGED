<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


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
			<xsl:call-template name="head" /> <!-- header.xsl -->

			<h1><xsl:call-template name="recordTitle" /></h1>

			<div class="messageArea">
				<div class="messageBody">
					<table cellspacing="0" cellpadding="5" border="0">
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
						<tr>
							<td><b>@@request_id@@: </b><img src="cid:request_id_barcode.png" alt="Request Barcode"/></td>
						</tr>
						<xsl:if  test="notification_data/request/selected_inventory_type='ITEM'" >
							<tr>
								<td><b>@@item_barcode@@: </b><img src="cid:item_id_barcode.png" alt="Item Barcode"/></td>
							</tr>
						</xsl:if>
						<xsl:if  test="notification_data/external_id != ''" >
							<tr>
								<td><b>@@external_id@@: </b><xsl:value-of select="notification_data/external_id"/></td>
							</tr>
						</xsl:if>
						<xsl:if test="notification_data/phys_item_display/isbn != ''">
							<tr>
								<td>@@isbn@@: <xsl:value-of select="notification_data/phys_item_display/isbn"/></td>
							</tr>
						</xsl:if>
						<xsl:if test="notification_data/phys_item_display/issn != ''">
							<tr>
								<td>@@issn@@: <xsl:value-of select="notification_data/phys_item_display/issn"/></td>
							</tr>
						</xsl:if>
						<xsl:if test="notification_data/phys_item_display/edition != ''">
							<tr>
								<td>@@edition@@: <xsl:value-of select="notification_data/phys_item_display/edition"/></td>
							</tr>
						</xsl:if>
						<xsl:if test="notification_data/phys_item_display/imprint != ''">
							<tr>
								<td>@@imprint@@: <xsl:value-of select="notification_data/phys_item_display/imprint"/></td>
							</tr>
						</xsl:if>

						<tr>
							<td>
								<h2><b>@@location@@: </b><xsl:value-of select="notification_data/phys_item_display/location_name"/>
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
							</td>
							<td>
								<xsl:if test="notification_data/phys_item_display/call_number != ''">
									<h2><b>@@call_number@@: </b><xsl:value-of select="notification_data/phys_item_display/call_number"/></h2>
								</xsl:if>	
								<xsl:if test="notification_data/phys_item_display/accession_number != ''">
									<h2><b>@@accession_number@@: </b><xsl:value-of select="notification_data/phys_item_display/accession_number"/></h2>
								</xsl:if>
							</td>
						</tr>
						<tr>
							<!-- nicomo : add barcode
							soit on affiche le barcode du niveau global (phys_item_display)
							soit on descend au niveau de chaque item -->
							<!-- TODO: tester sur du multiitems? -->	
							<xsl:choose>
								<xsl:when test="notification_data/phys_item_display/barcode != ''">
									<td><b>barcode: </b><xsl:value-of select="notification_data/phys_item_display/barcode"/></td>
								</xsl:when>
								<xsl:otherwise>
									<xsl:for-each select="notification_data/phys_item_display/available_items/available_item">
										<td><b>barcode: </b><xsl:value-of select="barcode"/>&#160;</td>
									</xsl:for-each>									
								</xsl:otherwise>
							</xsl:choose>
							<!-- nicomo : fin ajout barcode -->
						</tr>
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

						<tr>
							<td><b>@@move_to_library@@: </b><xsl:value-of select="notification_data/destination"/></td>
						</tr>

						<tr>
							<td><b>@@request_type@@: </b><xsl:value-of select="notification_data/request_type"/></td>
						</tr>
						<xsl:if test="notification_data/request/system_notes != ''">
							<tr>
								<td><b>@@system_notes@@:</b><xsl:value-of select="notification_data/request/system_notes"/></td>
							</tr>
						</xsl:if>

						<xsl:if test="notification_data/request/note != ''">
							<tr>
								<td><b>@@request_note@@:</b> <xsl:value-of select="notification_data/request/note"/></td>
							</tr>
						</xsl:if>

						<!-- USER STARTS HERE -->

						<xsl:if test="notification_data/user_for_printing/name">
							<tr>
								<td>
									<h4>@@requested_for@@: </h4>
									<p><xsl:value-of select="notification_data/user_for_printing/name"/></p>
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
								</td>
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
