from selenium import webdriver
from selenium.webdriver.common.keys import Keys
import time
quer_seqs = ["JL29_SSU-LSU", "NVP85_SSU-LSU", "GBAus27b_SSU-LSU", "NVP105_SSU-LSU", "JL62_SSU-LSU", "AD185_SSU-LSU", "JL58_SSU-LSU"]
with open("../sequence_data/SSU-LSU/unite_blast_hits.txt", "w") as outfile:
    outfile.write("Query\tSequence_hits\n")
    browser = webdriver.Chrome()
    #main_window = browser.current_window_handle
    for quer in quer_seqs:
        with open(F"../sequence_data/SSU-LSU/{quer}.fasta", "r") as search_file:
            text_quer = "".join(search_file.readlines())
            browser.get("https://unite.ut.ee/analysis.php#")
            query = browser.find_elements_by_xpath("//*[@id='paste1']")[1]
            query.send_keys(text_quer)
            submit = browser.find_element_by_xpath("//*[@id='blastn']/ul/li[3]/a")
            submit.click()
            query.clear()
            time.sleep(30)
            browser.switch_to.window(browser.window_handles[1])
            #browser.find_element_by_tag_name('body').send_keys(Keys.CONTROL + Keys.TAB)
            #browser.switch_to_window(main_window)
            links = browser.find_elements_by_xpath("//a[@href]")
            for i in links:
                url = i.get_attribute('href')
                print(url)
                if "id=" in url:
                    outfile.write(F"{quer}\t{url}\n")
            browser.find_element_by_tag_name('body').send_keys(Keys.CONTROL + 'w')
            browser.switch_to.window(browser.window_handles[0])
